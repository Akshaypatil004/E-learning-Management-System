<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Dashboard — LearnX LMS</title>
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
            <a class="nav-link active" href="${pageContext.request.contextPath}/dashboard">
              <i class="bi bi-grid me-1"></i>Dashboard
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/courses">
              <i class="bi bi-collection-play me-1"></i>Courses
            </a>
          </li>
          <c:if test="${sessionScope.role == 'admin'}">
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/admin">
                <i class="bi bi-shield-check me-1"></i>Admin
              </a>
            </li>
          </c:if>
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
    <div class="container">

      <!-- ── STUDENT DASHBOARD ── -->
      <c:if test="${sessionScope.role == 'student'}">

        <!-- Header -->
        <div class="dashboard-header animate-slideUp">
          <div class="d-flex align-items-center gap-3 mb-1">
            <div style="width:48px;height:48px;border-radius:50%;
                        background:var(--grad-primary);display:flex;
                        align-items:center;justify-content:center;
                        font-size:1.25rem;font-weight:700;color:white;
                        font-family:var(--font-display);">
              ${sessionScope.loggedInStudent.name.substring(0,1).toUpperCase()}
            </div>
            <div>
              <p style="font-size:0.825rem;color:var(--text-muted);margin:0;">
                Welcome back 👋
              </p>
              <h2 class="welcome-greeting mb-0">
                <span>${sessionScope.loggedInStudent.name}</span>
              </h2>
            </div>
          </div>
          <p style="color:var(--text-secondary);margin-top:0.5rem;">
            Track your progress and continue your learning journey.
          </p>
        </div>

        <!-- Stat Cards -->
        <div class="row g-3 mb-4 animate-slideUp stagger-1">
          <div class="col-6 col-lg-3">
            <div class="stat-card">
              <div class="stat-icon blue"><i class="bi bi-collection-play" style="color:var(--color-primary);"></i></div>
              <div class="stat-info">
                <div class="stat-value">${enrollments.size()}</div>
                <div class="stat-title">Enrolled Courses</div>
              </div>
            </div>
          </div>
          <div class="col-6 col-lg-3">
            <div class="stat-card">
              <div class="stat-icon cyan"><i class="bi bi-lightning-charge" style="color:var(--color-cyan);"></i></div>
              <div class="stat-info">
                <div class="stat-value">Active</div>
                <div class="stat-title">Learning Status</div>
              </div>
            </div>
          </div>
          <div class="col-6 col-lg-3">
            <div class="stat-card">
              <div class="stat-icon green"><i class="bi bi-patch-check" style="color:var(--color-success);"></i></div>
              <div class="stat-info">
                <div class="stat-value">0</div>
                <div class="stat-title">Certificates</div>
              </div>
            </div>
          </div>
          <div class="col-6 col-lg-3">
            <div class="stat-card">
              <div class="stat-icon amber"><i class="bi bi-fire" style="color:var(--color-warning);"></i></div>
              <div class="stat-info">
                <div class="stat-value">1</div>
                <div class="stat-title">Day Streak</div>
              </div>
            </div>
          </div>
        </div>

        <!-- Enrolled Courses -->
        <h4 class="section-title mb-3 animate-slideUp stagger-2">
          My Courses
          <span style="font-size:0.875rem;color:var(--text-muted);
                       font-weight:400;margin-left:0.5rem;">
            (${enrollments.size()} enrolled)
          </span>
        </h4>

        <c:choose>
          <c:when test="${empty enrollments}">
            <div class="lms-card text-center py-5 animate-fadeIn">
              <div style="font-size:3.5rem;margin-bottom:1rem;">🎓</div>
              <h5 style="color:var(--text-primary);font-family:var(--font-display);">
                No courses yet
              </h5>
              <p style="color:var(--text-secondary);margin-bottom:1.5rem;">
                Explore our course library and start learning today.
              </p>
              <a href="${pageContext.request.contextPath}/courses"
                 class="btn-primary-custom" style="text-decoration:none;display:inline-block;">
                <i class="bi bi-search me-2"></i>Browse Courses
              </a>
            </div>
          </c:when>
          <c:otherwise>
            <div class="row g-4">
              <c:forEach var="enrollment" items="${enrollments}" varStatus="status">
                <div class="col-12 col-md-6 col-lg-4 animate-slideUp stagger-${status.index % 6 + 1}">
                  <div class="course-card">

                    <!-- Banner -->
                    <div class="course-card-img"
                         style="background:linear-gradient(135deg,
                           hsl(${(status.index * 47 + 220) % 360},60%,20%),
                           hsl(${(status.index * 47 + 260) % 360},60%,30%));">
                      <span style="position:relative;z-index:1;font-size:2.5rem;">📘</span>
                    </div>

                    <div class="course-card-body">
                      <span class="course-badge">Enrolled</span>
                      <h6 style="font-family:var(--font-display);font-weight:600;
                                 color:var(--text-primary);margin-bottom:1rem;">
                        Course #${enrollment.courseId}
                      </h6>

                      <!-- Progress -->
                      <c:set var="completed" value="${requestScope['completed_'.concat(enrollment.courseId)]}"/>
                      <c:set var="total"     value="${requestScope['total_'.concat(enrollment.courseId)]}"/>
                      <c:set var="pct"       value="${total > 0 ? (completed * 100 / total) : 0}"/>

                      <div class="d-flex justify-content-between mb-1"
                           style="font-size:0.8rem;color:var(--text-secondary);">
                        <span>Progress</span>
                        <span style="color:var(--color-primary);font-weight:600;">
                          ${pct}%
                        </span>
                      </div>
                      <div class="lms-progress mb-3">
                        <div class="lms-progress-bar" style="width:${pct}%;"></div>
                      </div>
                      <p style="font-size:0.8rem;color:var(--text-muted);">
                        ${completed} / ${total} lessons completed
                      </p>
                    </div>

                    <div class="lms-card-footer">
                      <a href="${pageContext.request.contextPath}/lessons?courseId=${enrollment.courseId}"
                         class="btn-primary-custom w-100 text-center"
                         style="text-decoration:none;display:block;">
                        <i class="bi bi-play-circle me-2"></i>
                        <c:choose>
                          <c:when test="${pct == 0}">Start Learning</c:when>
                          <c:when test="${pct == 100}">Review Course</c:when>
                          <c:otherwise>Continue Learning</c:otherwise>
                        </c:choose>
                      </a>
                    </div>

                  </div>
                </div>
              </c:forEach>
            </div>
          </c:otherwise>
        </c:choose>

      </c:if>

      <!-- ── INSTRUCTOR DASHBOARD ── -->
      <c:if test="${sessionScope.role == 'instructor'}">

        <!-- Header -->
        <div class="dashboard-header animate-slideUp">
          <div class="d-flex align-items-center gap-3 mb-1">
            <div style="width:48px;height:48px;border-radius:50%;
                        background:var(--grad-accent);display:flex;
                        align-items:center;justify-content:center;
                        font-size:1.25rem;font-weight:700;color:white;
                        font-family:var(--font-display);">
              ${sessionScope.loggedInInstructor.name.substring(0,1).toUpperCase()}
            </div>
            <div>
              <p style="font-size:0.825rem;color:var(--text-muted);margin:0;">
                Instructor Portal 👨‍🏫
              </p>
              <h2 class="welcome-greeting mb-0">
                <span>${sessionScope.loggedInInstructor.name}</span>
              </h2>
            </div>
          </div>
          <p style="color:var(--text-secondary);margin-top:0.5rem;">
            Manage your courses and track student engagement.
          </p>
        </div>

        <!-- Stat Cards -->
        <div class="row g-3 mb-4 animate-slideUp stagger-1">
          <div class="col-6 col-lg-3">
            <div class="stat-card">
              <div class="stat-icon blue">
                <i class="bi bi-collection" style="color:var(--color-primary);"></i>
              </div>
              <div class="stat-info">
                <div class="stat-value">${courses.size()}</div>
                <div class="stat-title">Total Courses</div>
              </div>
            </div>
          </div>
          <div class="col-6 col-lg-3">
            <div class="stat-card">
              <div class="stat-icon green">
                <i class="bi bi-people" style="color:var(--color-success);"></i>
              </div>
              <div class="stat-info">
                <div class="stat-value">—</div>
                <div class="stat-title">Total Students</div>
              </div>
            </div>
          </div>
          <div class="col-6 col-lg-3">
            <div class="stat-card">
              <div class="stat-icon cyan">
                <i class="bi bi-bar-chart" style="color:var(--color-cyan);"></i>
              </div>
              <div class="stat-info">
                <div class="stat-value">—</div>
                <div class="stat-title">Completion Rate</div>
              </div>
            </div>
          </div>
          <div class="col-6 col-lg-3">
            <div class="stat-card">
              <div class="stat-icon amber">
                <i class="bi bi-star" style="color:var(--color-warning);"></i>
              </div>
              <div class="stat-info">
                <div class="stat-value">—</div>
                <div class="stat-title">Avg. Rating</div>
              </div>
            </div>
          </div>
        </div>

        <!-- My Courses -->
        <h4 class="section-title mb-3 animate-slideUp stagger-2">My Courses</h4>

        <c:choose>
          <c:when test="${empty courses}">
            <div class="lms-card text-center py-5 animate-fadeIn">
              <div style="font-size:3.5rem;margin-bottom:1rem;">📝</div>
              <h5 style="color:var(--text-primary);font-family:var(--font-display);">
                No courses yet
              </h5>
              <p style="color:var(--text-secondary);">
                Contact admin to create your first course.
              </p>
            </div>
          </c:when>
          <c:otherwise>
            <div class="row g-4">
              <c:forEach var="course" items="${courses}" varStatus="status">
                <div class="col-12 col-md-6 col-lg-4 animate-slideUp stagger-${status.index % 6 + 1}">
                  <div class="course-card">
                    <div class="course-card-img"
                         style="background:linear-gradient(135deg,
                           hsl(${(status.index * 53 + 180) % 360},60%,20%),
                           hsl(${(status.index * 53 + 220) % 360},60%,30%));">
                      <span style="position:relative;z-index:1;font-size:2.5rem;">📖</span>
                    </div>
                    <div class="course-card-body">
                      <span class="course-badge">Published</span>
                      <h6 style="font-family:var(--font-display);font-weight:600;
                                 color:var(--text-primary);margin-bottom:0.5rem;">
                        ${course.title}
                      </h6>
                      <p style="color:var(--text-secondary);font-size:0.875rem;
                                display:-webkit-box;-webkit-line-clamp:2;
                                -webkit-box-orient:vertical;overflow:hidden;">
                        <c:choose>
                          <c:when test="${not empty course.description}">
                            ${course.description}
                          </c:when>
                          <c:otherwise>No description provided.</c:otherwise>
                        </c:choose>
                      </p>
                    </div>
                    <div class="lms-card-footer d-flex gap-2">
                      <a href="${pageContext.request.contextPath}/lessons?courseId=${course.courseId}"
                         class="btn-primary-custom"
                         style="flex:1;text-align:center;text-decoration:none;
                                font-size:0.85rem;padding:0.5rem;">
                        <i class="bi bi-eye me-1"></i>View Lessons
                      </a>
                    </div>
                  </div>
                </div>
              </c:forEach>
            </div>
          </c:otherwise>
        </c:choose>

      </c:if>

    </div>
  </div>

  <!-- Animate progress bars on load -->
  <script>
    window.addEventListener('load', function () {
      document.querySelectorAll('.lms-progress-bar').forEach(function (bar) {
        const target = bar.style.width;
        bar.style.width = '0%';
        setTimeout(function () { bar.style.width = target; }, 300);
      });
    });
  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>