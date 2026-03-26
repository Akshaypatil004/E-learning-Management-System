package com.lms.util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnectionPool {

    // ─── Singleton instance ───────────────────────────────────
    private static DBConnectionPool instance;
    private final HikariDataSource dataSource;

    // ─── Private constructor ──────────────────────────────────
    private DBConnectionPool() {
        Properties props = loadProperties();

        // Read which DB is active — oracle | mysql
        String activeDb = props.getProperty("db.active", "oracle").trim().toLowerCase();

        String url;
        String username;
        String password;
        String driver;

        if (activeDb.equals("mysql")) {
            url = props.getProperty("db.mysql.url");
            username = props.getProperty("db.mysql.username");
            password = props.getProperty("db.mysql.password");
            driver = props.getProperty("db.mysql.driver");
        } else {
            // Default — Oracle 19c
            url = props.getProperty("db.oracle.url");
            username = props.getProperty("db.oracle.username");
            password = props.getProperty("db.oracle.password");
            driver = props.getProperty("db.oracle.driver");
        }

        HikariConfig config = new HikariConfig();
        config.setJdbcUrl(url);
        config.setUsername(username);
        config.setPassword(password);
        config.setDriverClassName(driver);

        config.setMaximumPoolSize(
                Integer.parseInt(props.getProperty("db.pool.maximumPoolSize", "10")));
        config.setMinimumIdle(
                Integer.parseInt(props.getProperty("db.pool.minimumIdle", "2")));
        config.setConnectionTimeout(
                Long.parseLong(props.getProperty("db.pool.connectionTimeout", "30000")));
        config.setIdleTimeout(
                Long.parseLong(props.getProperty("db.pool.idleTimeout", "600000")));
        config.setMaxLifetime(
                Long.parseLong(props.getProperty("db.pool.maxLifetime", "1800000")));

        config.setPoolName("LMS-HikariPool-" + activeDb.toUpperCase());
        config.addDataSourceProperty("cachePrepStmts", "true");
        config.addDataSourceProperty("prepStmtCacheSize", "250");
        config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");

        this.dataSource = new HikariDataSource(config);
    }

    // ─── Load properties from classpath ──────────────────────
    private Properties loadProperties() {
        Properties props = new Properties();
        try (InputStream input = getClass()
                .getClassLoader()
                .getResourceAsStream("application.properties")) {

            if (input == null) {
                throw new RuntimeException(
                        "application.properties not found in classpath");
            }
            props.load(input);

        } catch (IOException e) {
            throw new RuntimeException(
                    "Failed to load application.properties", e);
        }
        return props;
    }

    // ─── Singleton accessor — thread safe ────────────────────
    public static synchronized DBConnectionPool getInstance() {
        if (instance == null) {
            instance = new DBConnectionPool();
        }
        return instance;
    }

    // ─── Get a connection from the pool ──────────────────────
    public Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    // ─── Shutdown the pool cleanly ───────────────────────────
    public void shutdown() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
        }
    }
}