<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Lessons — LearnX LMS</title>
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
      <div class="d-flex align-items-center gap-3 mb-2 animate-slideUp">
        <a href="${pageContext.request.contextPath}/dashboard"
           style="color:var(--text-muted);text-decoration:none;font-size:0.875rem;
                  display:flex;align-items:center;gap:0.375rem;">
          <i class="bi bi-arrow-left"></i> Back to Dashboard
        </a>
      </div>

      <div class="animate-slideUp stagger-1 mb-4">
        <div class="hero-badge" style="margin-bottom:0.75rem;">
          <i class="bi bi-collection-play"></i> Course Lessons
        </div>
        <h2 style="font-family:var(--font-display);font-weight:700;
                   color:var(--text-primary);margin-bottom:0.5rem;">
          Your Learning Path
        </h2>
        <p style="color:var(--text-secondary);">
          Complete each lesson in order to track your progress.
        </p>
      </div>

      <div class="row g-4">

        <!-- Lesson List -->
        <div class="col-12 col-lg-8">

          <!-- Progress Overview Card -->
          <div class="lms-card mb-4 animate-slideUp stagger-2">
            <div class="lms-card-body">
              <div class="d-flex justify-content-between align-items-center mb-2">
                <span style="font-weight:600;color:var(--text-primary);
                             font-family:var(--font-display);">
                  Overall Progress
                </span>
                <span id="progressPct"
                      style="color:var(--color-primary);font-weight:700;
                             font-family:var(--font-display);font-size:1.1rem;">
                  0%
                </span>
              </div>
              <div class="lms-progress" style="height:8px;">
                <div class="lms-progress-bar" id="overallBar" style="width:0%;"></div>
              </div>
              <div class="d-flex justify-content-between mt-2"
                   style="font-size:0.8rem;color:var(--text-muted);">
                <span id="completedCount">0 completed</span>
                <span id="totalCount">${lessons.size()} total lessons</span>
              </div>
            </div>
          </div>

          <!-- Lessons -->
          <c:choose>
            <c:when test="${empty lessons}">
              <div class="lms-card text-center py-5 animate-fadeIn">
                <div style="font-size:3.5rem;margin-bottom:1rem;">📭</div>
                <h5 style="color:var(--text-primary);font-family:var(--font-display);">
                  No lessons yet
                </h5>
                <p style="color:var(--text-secondary);">
                  The instructor hasn't added lessons to this course yet.
                </p>
              </div>
            </c:when>
            <c:otherwise>
              <div id="lessonList">
                <c:forEach var="lesson" items="${lessons}" varStatus="status">

                  <%-- Check if this lesson is completed --%>
                  <c:set var="isDone" value="false"/>
                  <c:forEach var="p" items="${progressList}">
                    <c:if test="${p.lessonId == lesson.lessonId && p.completed}">
                      <c:set var="isDone" value="true"/>
                    </c:if>
                  </c:forEach>

                  <div class="lesson-item animate-slideUp stagger-${status.index % 6 + 1}
                              ${isDone ? 'done-item' : ''}">

                    <!-- Number / Check -->
                    <div class="lesson-number ${isDone ? 'completed' : ''}">
                      <c:choose>
                        <c:when test="${isDone}">
                          <i class="bi bi-check-lg"></i>
                        </c:when>
                        <c:otherwise>
                          ${status.index + 1}
                        </c:otherwise>
                      </c:choose>
                    </div>

                    <!-- Title + Content -->
                    <div class="lesson-title">
                      <div style="font-weight:600;color:var(--text-primary);
                                  margin-bottom:0.2rem;">
                        ${lesson.title}
                      </div>
                      <c:if test="${not empty lesson.content}">
                        <div style="font-size:0.8rem;color:var(--text-muted);
                                    display:-webkit-box;-webkit-line-clamp:1;
                                    -webkit-box-orient:vertical;overflow:hidden;">
                          ${lesson.content}
                        </div>
                      </c:if>
                    </div>

                    <!-- Status + Action -->
                    <div class="d-flex align-items-center gap-2 flex-shrink-0">
                      <c:choose>
                        <c:when test="${isDone}">
                          <span class="lesson-status done">
                            <i class="bi bi-check-circle me-1"></i>Done
                          </span>
                        </c:when>
                        <c:otherwise>
                          <form action="${pageContext.request.contextPath}/progress"
                                method="post" style="margin:0;">
                            <input type="hidden" name="lessonId" value="${lesson.lessonId}"/>
                            <input type="hidden" name="courseId" value="${courseId}"/>
                            <button type="submit" class="btn-primary-custom"
                                    style="padding:0.4rem 1rem;font-size:0.8rem;">
                              <i class="bi bi-play-fill me-1"></i>Mark Done
                            </button>
                          </form>
                        </c:otherwise>
                      </c:choose>
                    </div>

                  </div>
                </c:forEach>
              </div>
            </c:otherwise>
          </c:choose>

        </div>

        <!-- Sidebar -->
        <div class="col-12 col-lg-4">

          <!-- Course Info Card -->
          <div class="lms-card animate-slideUp stagger-2 mb-3">
            <div class="lms-card-header">
              <h6 style="font-family:var(--font-display);font-weight:600;
                         color:var(--text-primary);margin:0;">
                <i class="bi bi-info-circle me-2" style="color:var(--color-primary);"></i>
                Course Info
              </h6>
            </div>
            <div class="lms-card-body">
              <div class="d-flex flex-column gap-3">
                <div class="d-flex justify-content-between"
                     style="font-size:0.875rem;">
                  <span style="color:var(--text-secondary);">Total Lessons</span>
                  <span style="color:var(--text-primary);font-weight:600;">
                    ${lessons.size()}
                  </span>
                </div>
                <div class="d-flex justify-content-between"
                     style="font-size:0.875rem;">
                  <span style="color:var(--text-secondary);">Format</span>
                  <span style="color:var(--text-primary);font-weight:600;">Self-paced</span>
                </div>
                <div class="d-flex justify-content-between"
                     style="font-size:0.875rem;">
                  <span style="color:var(--text-secondary);">Certificate</span>
                  <span style="color:var(--color-success);font-weight:600;">
                    <i class="bi bi-patch-check me-1"></i>On completion
                  </span>
                </div>
              </div>
            </div>
          </div>

          <!-- Tips Card -->
          <div class="lms-card animate-slideUp stagger-3">
            <div class="lms-card-header">
              <h6 style="font-family:var(--font-display);font-weight:600;
                         color:var(--text-primary);margin:0;">
                <i class="bi bi-lightbulb me-2" style="color:var(--color-warning);"></i>
                Learning Tips
              </h6>
            </div>
            <div class="lms-card-body">
              <div class="d-flex flex-column gap-2"
                   style="font-size:0.85rem;color:var(--text-secondary);">
                <div class="d-flex gap-2">
                  <i class="bi bi-check2-circle"
                     style="color:var(--color-success);flex-shrink:0;margin-top:2px;"></i>
                  Complete lessons in order for best results
                </div>
                <div class="d-flex gap-2">
                  <i class="bi bi-check2-circle"
                     style="color:var(--color-success);flex-shrink:0;margin-top:2px;"></i>
                  Take notes as you learn each concept
                </div>
                <div class="d-flex gap-2">
                  <i class="bi bi-check2-circle"
                     style="color:var(--color-success);flex-shrink:0;margin-top:2px;"></i>
                  Revisit completed lessons anytime
                </div>
                <div class="d-flex gap-2">
                  <i class="bi bi-check2-circle"
                     style="color:var(--color-success);flex-shrink:0;margin-top:2px;"></i>
                  Finish all lessons to earn your certificate
                </div>
              </div>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>

  <script>
    // Calculate and animate progress bar
    window.addEventListener('load', function () {
      const total     = ${lessons.size()};
      const doneItems = document.querySelectorAll('.done-item').length;
      const pct       = total > 0 ? Math.round((doneItems / total) * 100) : 0;

      document.getElementById('progressPct').textContent  = pct + '%';
      document.getElementById('completedCount').textContent = doneItems + ' completed';

      setTimeout(function () {
        document.getElementById('overallBar').style.width = pct + '%';
      }, 300);
    });
  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>