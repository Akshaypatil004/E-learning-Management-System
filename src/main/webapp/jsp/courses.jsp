<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Courses — LearnX LMS</title>
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
            <a class="nav-link active" href="${pageContext.request.contextPath}/courses">
              <i class="bi bi-collection-play me-1"></i>Courses
            </a>
          </li>
          <li class="nav-item ms-2">
            <a href="${pageContext.request.contextPath}/logout"
               class="btn-secondary-custom" style="padding:0.5rem 1.25rem;
               border-radius:var(--radius-sm);font-size:0.875rem;display:inline-block;
               text-decoration:none;">
              <i class="bi bi-box-arrow-right me-1"></i>Logout
            </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="content-layer">

    <!-- Hero -->
    <section class="hero-section">
      <div class="container">
        <div class="hero-badge">
          <i class="bi bi-stars"></i> All Courses
        </div>
        <h1 class="hero-title">
          Expand Your <span class="text-gradient">Knowledge</span><br/>
          Learn Without Limits
        </h1>
        <p class="hero-subtitle">
          Explore our curated library of courses taught by expert instructors.
          Start learning at your own pace today.
        </p>

        <!-- Search Bar -->
        <div class="d-flex justify-content-center">
          <div style="position:relative;width:100%;max-width:480px;">
            <i class="bi bi-search" style="position:absolute;left:1.125rem;top:50%;
               transform:translateY(-50%);color:var(--text-muted);font-size:1rem;"></i>
            <input type="text" id="searchInput" class="lms-input"
                   placeholder="Search courses..."
                   style="padding-left:3rem;border-radius:99px;"/>
          </div>
        </div>

        <!-- Stats -->
        <div class="stats-strip mt-4">
          <div class="stat-item">
            <div class="stat-number">${courses.size()}</div>
            <div class="stat-label">Total Courses</div>
          </div>
          <div class="stat-item">
            <div class="stat-number">∞</div>
            <div class="stat-label">Hours of Learning</div>
          </div>
          <div class="stat-item">
            <div class="stat-number">100%</div>
            <div class="stat-label">Self-Paced</div>
          </div>
        </div>
      </div>
    </section>

    <!-- Course Grid -->
    <section class="pb-5">
      <div class="container">
        <c:choose>
          <c:when test="${empty courses}">
            <!-- Empty State -->
            <div class="text-center py-5">
              <div style="font-size:4rem;margin-bottom:1rem;">📚</div>
              <h3 style="color:var(--text-primary);font-family:var(--font-display);">
                No courses yet
              </h3>
              <p style="color:var(--text-secondary);">
                Check back soon — new courses are being added.
              </p>
            </div>
          </c:when>
          <c:otherwise>
            <div class="row g-4" id="courseGrid">
              <c:forEach var="course" items="${courses}" varStatus="status">
                <div class="col-12 col-md-6 col-lg-4 course-col animate-slideUp stagger-${status.index % 6 + 1}">
                  <div class="course-card">

                    <!-- Course Banner -->
                    <div class="course-card-img"
                         style="background:linear-gradient(135deg,hsl(${(status.index * 47 + 220) % 360},70%,25%),hsl(${(status.index * 47 + 260) % 360},70%,35%));">
                      <span style="position:relative;z-index:1;font-size:3rem;">
                        <c:choose>
                          <c:when test="${status.index % 6 == 0}">💻</c:when>
                          <c:when test="${status.index % 6 == 1}">🎨</c:when>
                          <c:when test="${status.index % 6 == 2}">📊</c:when>
                          <c:when test="${status.index % 6 == 3}">🔬</c:when>
                          <c:when test="${status.index % 6 == 4}">🚀</c:when>
                          <c:otherwise>🧠</c:otherwise>
                        </c:choose>
                      </span>
                    </div>

                    <div class="course-card-body">
                      <span class="course-badge">Course</span>
                      <h5 style="font-family:var(--font-display);font-weight:600;
                                 color:var(--text-primary);margin-bottom:0.625rem;
                                 font-size:1.05rem;">
                        ${course.title}
                      </h5>
                      <p style="color:var(--text-secondary);font-size:0.875rem;
                                line-height:1.6;margin-bottom:1.25rem;
                                display:-webkit-box;-webkit-line-clamp:2;
                                -webkit-box-orient:vertical;overflow:hidden;">
                        <c:choose>
                          <c:when test="${not empty course.description}">
                            ${course.description}
                          </c:when>
                          <c:otherwise>
                            Dive deep into this course and build real-world skills.
                          </c:otherwise>
                        </c:choose>
                      </p>

                      <!-- Meta -->
                      <div class="d-flex align-items-center gap-3 mb-3"
                           style="font-size:0.8rem;color:var(--text-muted);">
                        <span><i class="bi bi-person me-1"></i>Expert Instructor</span>
                        <span><i class="bi bi-clock me-1"></i>Self-paced</span>
                      </div>
                    </div>

                    <div class="lms-card-footer d-flex align-items-center justify-content-between">
                      <span style="font-size:0.8rem;color:var(--color-success);
                                   font-weight:600;">
                        <i class="bi bi-patch-check-fill me-1"></i>Free
                      </span>
                      <form action="${pageContext.request.contextPath}/enroll"
                            method="post" style="margin:0;">
                        <input type="hidden" name="courseId" value="${course.courseId}"/>
                        <button type="submit"
                                class="btn-primary-custom"
                                style="padding:0.5rem 1.25rem;font-size:0.85rem;">
                          Enroll Now <i class="bi bi-arrow-right ms-1"></i>
                        </button>
                      </form>
                    </div>

                  </div>
                </div>
              </c:forEach>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </section>

  </div>

  <script>
    // Live search filter
    document.getElementById('searchInput').addEventListener('input', function () {
      const query = this.value.toLowerCase();
      document.querySelectorAll('.course-col').forEach(function (col) {
        const title = col.querySelector('h5').textContent.toLowerCase();
        col.style.display = title.includes(query) ? '' : 'none';
      });
    });
  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>