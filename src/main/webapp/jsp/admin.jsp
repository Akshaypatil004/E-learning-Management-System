<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Admin Panel — LearnX LMS</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet"/>
</head>
<body class="bg-mesh">

  <!-- Navbar -->
  <nav class="lms-navbar navbar navbar-expand-lg">
    <div class="container">
      <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">⚡ LearnX</a>
      <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse"
              data-bs-target="#navMenu" style="color:var(--text-secondary);">
        <i class="bi bi-list fs-4"></i>
      </button>
      <div class="collapse navbar-collapse" id="navMenu">
        <ul class="navbar-nav ms-auto align-items-center gap-1">
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
              <i class="bi bi-grid me-1"></i>Dashboard
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/courses">
              <i class="bi bi-collection-play me-1"></i>Courses
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" href="${pageContext.request.contextPath}/admin">
              <i class="bi bi-shield-check me-1"></i>Admin
            </a>
          </li>
          <li class="nav-item ms-2">
            <a href="${pageContext.request.contextPath}/logout"
               class="btn-secondary-custom"
               style="padding:0.5rem 1.25rem;border-radius:var(--radius-sm);
                      font-size:0.875rem;display:inline-block;text-decoration:none;">
              <i class="bi bi-box-arrow-right me-1"></i>Logout
            </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="content-layer">
    <div class="container py-5">

      <!-- Header -->
      <div class="animate-slideUp mb-4">
        <div class="hero-badge" style="margin-bottom:0.75rem;">
          <i class="bi bi-shield-check"></i> Admin Panel
        </div>
        <h2 style="font-family:var(--font-display);font-weight:700;
                   color:var(--text-primary);margin-bottom:0.375rem;">
          System Overview
        </h2>
        <p style="color:var(--text-secondary);">
          Manage students, instructors, and courses from one place.
        </p>
      </div>

      <!-- Stat Cards -->
      <div class="row g-3 mb-5 animate-slideUp stagger-1">
        <div class="col-6 col-lg-4">
          <div class="stat-card">
            <div class="stat-icon blue">
              <i class="bi bi-people-fill" style="color:var(--color-primary);"></i>
            </div>
            <div class="stat-info">
              <div class="stat-value">${students.size()}</div>
              <div class="stat-title">Total Students</div>
            </div>
          </div>
        </div>
        <div class="col-6 col-lg-4">
          <div class="stat-card">
            <div class="stat-icon cyan">
              <i class="bi bi-person-video3" style="color:var(--color-cyan);"></i>
            </div>
            <div class="stat-info">
              <div class="stat-value">${instructors.size()}</div>
              <div class="stat-title">Total Instructors</div>
            </div>
          </div>
        </div>
        <div class="col-6 col-lg-4">
          <div class="stat-card">
            <div class="stat-icon green">
              <i class="bi bi-collection-fill" style="color:var(--color-success);"></i>
            </div>
            <div class="stat-info">
              <div class="stat-value">${courses.size()}</div>
              <div class="stat-title">Total Courses</div>
            </div>
          </div>
        </div>
      </div>

      <!-- Tab Navigation -->
      <div class="lms-tabs animate-slideUp stagger-2">
        <button class="lms-tab active" onclick="showTab('students', this)">
          <i class="bi bi-people me-1"></i>Students
        </button>
        <button class="lms-tab" onclick="showTab('instructors', this)">
          <i class="bi bi-person-video3 me-1"></i>Instructors
        </button>
        <button class="lms-tab" onclick="showTab('courses', this)">
          <i class="bi bi-collection me-1"></i>Courses
        </button>
      </div>

      <!-- ── Students Tab ── -->
      <div id="tab-students" class="tab-panel animate-fadeIn">
        <div class="lms-card">
          <div class="lms-card-header d-flex justify-content-between align-items-center">
            <h6 style="font-family:var(--font-display);font-weight:600;
                       color:var(--text-primary);margin:0;">
              <i class="bi bi-people me-2" style="color:var(--color-primary);"></i>
              All Students
            </h6>
            <span style="font-size:0.8rem;color:var(--text-muted);">
              ${students.size()} total
            </span>
          </div>
          <div style="overflow-x:auto;">
            <c:choose>
              <c:when test="${empty students}">
                <div class="text-center py-5">
                  <div style="font-size:3rem;margin-bottom:0.75rem;">👥</div>
                  <p style="color:var(--text-secondary);">No students registered yet.</p>
                </div>
              </c:when>
              <c:otherwise>
                <table class="lms-table">
                  <thead>
                    <tr>
                      <th>#</th>
                      <th>Name</th>
                      <th>Email</th>
                      <th>Joined</th>
                      <th>Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="student" items="${students}" varStatus="s">
                      <tr>
                        <td style="color:var(--text-muted);font-size:0.85rem;">
                          ${s.index + 1}
                        </td>
                        <td>
                          <div class="d-flex align-items-center gap-2">
                            <div style="width:32px;height:32px;border-radius:50%;
                                        background:var(--grad-primary);display:flex;
                                        align-items:center;justify-content:center;
                                        font-size:0.8rem;font-weight:700;color:white;
                                        flex-shrink:0;">
                              ${student.name.substring(0,1).toUpperCase()}
                            </div>
                            <span style="font-weight:500;">${student.name}</span>
                          </div>
                        </td>
                        <td style="color:var(--text-secondary);">${student.email}</td>
                        <td style="color:var(--text-muted);font-size:0.85rem;">
                          <c:choose>
                            <c:when test="${student.createdAt.present}">
                              ${student.createdAt.get().toLocalDate()}
                            </c:when>
                            <c:otherwise>—</c:otherwise>
                          </c:choose>
                        </td>
                        <td>
                          <button class="btn-danger-custom">
                            <i class="bi bi-trash me-1"></i>Remove
                          </button>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>

      <!-- ── Instructors Tab ── -->
      <div id="tab-instructors" class="tab-panel animate-fadeIn" style="display:none;">
        <div class="lms-card">
          <div class="lms-card-header d-flex justify-content-between align-items-center">
            <h6 style="font-family:var(--font-display);font-weight:600;
                       color:var(--text-primary);margin:0;">
              <i class="bi bi-person-video3 me-2" style="color:var(--color-cyan);"></i>
              All Instructors
            </h6>
            <span style="font-size:0.8rem;color:var(--text-muted);">
              ${instructors.size()} total
            </span>
          </div>
          <div style="overflow-x:auto;">
            <c:choose>
              <c:when test="${empty instructors}">
                <div class="text-center py-5">
                  <div style="font-size:3rem;margin-bottom:0.75rem;">👨‍🏫</div>
                  <p style="color:var(--text-secondary);">No instructors registered yet.</p>
                </div>
              </c:when>
              <c:otherwise>
                <table class="lms-table">
                  <thead>
                    <tr>
                      <th>#</th>
                      <th>Name</th>
                      <th>Email</th>
                      <th>Joined</th>
                      <th>Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="instructor" items="${instructors}" varStatus="s">
                      <tr>
                        <td style="color:var(--text-muted);font-size:0.85rem;">
                          ${s.index + 1}
                        </td>
                        <td>
                          <div class="d-flex align-items-center gap-2">
                            <div style="width:32px;height:32px;border-radius:50%;
                                        background:var(--grad-accent);display:flex;
                                        align-items:center;justify-content:center;
                                        font-size:0.8rem;font-weight:700;color:white;
                                        flex-shrink:0;">
                              ${instructor.name.substring(0,1).toUpperCase()}
                            </div>
                            <span style="font-weight:500;">${instructor.name}</span>
                          </div>
                        </td>
                        <td style="color:var(--text-secondary);">${instructor.email}</td>
                        <td style="color:var(--text-muted);font-size:0.85rem;">
                          <c:choose>
                            <c:when test="${instructor.createdAt.present}">
                              ${instructor.createdAt.get().toLocalDate()}
                            </c:when>
                            <c:otherwise>—</c:otherwise>
                          </c:choose>
                        </td>
                        <td>
                          <button class="btn-danger-custom">
                            <i class="bi bi-trash me-1"></i>Remove
                          </button>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>

      <!-- ── Courses Tab ── -->
      <div id="tab-courses" class="tab-panel animate-fadeIn" style="display:none;">
        <div class="lms-card">
          <div class="lms-card-header d-flex justify-content-between align-items-center">
            <h6 style="font-family:var(--font-display);font-weight:600;
                       color:var(--text-primary);margin:0;">
              <i class="bi bi-collection me-2" style="color:var(--color-success);"></i>
              All Courses
            </h6>
            <span style="font-size:0.8rem;color:var(--text-muted);">
              ${courses.size()} total
            </span>
          </div>
          <div style="overflow-x:auto;">
            <c:choose>
              <c:when test="${empty courses}">
                <div class="text-center py-5">
                  <div style="font-size:3rem;margin-bottom:0.75rem;">📚</div>
                  <p style="color:var(--text-secondary);">No courses created yet.</p>
                </div>
              </c:when>
              <c:otherwise>
                <table class="lms-table">
                  <thead>
                    <tr>
                      <th>#</th>
                      <th>Title</th>
                      <th>Instructor ID</th>
                      <th>Created</th>
                      <th>Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="course" items="${courses}" varStatus="s">
                      <tr>
                        <td style="color:var(--text-muted);font-size:0.85rem;">
                          ${s.index + 1}
                        </td>
                        <td>
                          <div class="d-flex align-items-center gap-2">
                            <div style="width:32px;height:32px;border-radius:var(--radius-sm);
                                        background:rgba(16,185,129,0.15);display:flex;
                                        align-items:center;justify-content:center;
                                        font-size:1rem;flex-shrink:0;">📘</div>
                            <span style="font-weight:500;">${course.title}</span>
                          </div>
                        </td>
                        <td style="color:var(--text-secondary);">
                          #${course.instructorId}
                        </td>
                        <td style="color:var(--text-muted);font-size:0.85rem;">
                          <c:choose>
                            <c:when test="${course.createdAt.present}">
                              ${course.createdAt.get().toLocalDate()}
                            </c:when>
                            <c:otherwise>—</c:otherwise>
                          </c:choose>
                        </td>
                        <td>
                          <button class="btn-danger-custom">
                            <i class="bi bi-trash me-1"></i>Remove
                          </button>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>

    </div>
  </div>

  <script>
    function showTab(name, btn) {
      // Hide all panels
      document.querySelectorAll('.tab-panel').forEach(function (p) {
        p.style.display = 'none';
      });
      // Deactivate all tabs
      document.querySelectorAll('.lms-tab').forEach(function (t) {
        t.classList.remove('active');
      });
      // Show selected panel
      document.getElementById('tab-' + name).style.display = 'block';
      btn.classList.add('active');
    }
  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>