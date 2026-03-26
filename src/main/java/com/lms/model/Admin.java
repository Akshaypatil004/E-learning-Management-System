package com.lms.model;

import java.time.LocalDateTime;
import java.util.Optional;

public class Admin {

    private int adminId;
    private String name;
    private String email;
    private String password;
    private LocalDateTime createdAt;

    // ─── Constructors ─────────────────────────────────────────

    public Admin() {
    }

    public Admin(int adminId, String name, String email,
            String password, LocalDateTime createdAt) {
        this.adminId = adminId;
        this.name = name;
        this.email = email;
        this.password = password;
        this.createdAt = createdAt;
    }

    // Constructor without ID — used when creating a new admin
    public Admin(String name, String email, String password) {
        this.name = name;
        this.email = email;
        this.password = password;
    }

    // ─── Getters ──────────────────────────────────────────────

    public int getAdminId() {
        return adminId;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public Optional<LocalDateTime> getCreatedAt() {
        return Optional.ofNullable(createdAt);
    }

    // ─── Setters ──────────────────────────────────────────────

    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    // ─── toString ─────────────────────────────────────────────

    @Override
    public String toString() {
        return "Admin{" +
                "adminId=" + adminId +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}