<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>LearnX — Modern E-Learning Platform</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet"/>
</head>
<body class="bg-mesh">

  <!-- Background Orbs -->
  <div style="position:fixed;top:-300px;left:-200px;width:700px;height:700px;
              background:radial-gradient(circle,rgba(99,102,241,0.10),transparent 70%);
              pointer-events:none;z-index:0;"></div>
  <div style="position:fixed;bottom:-300px;right:-200px;width:700px;height:700px;
              background:radial-gradient(circle,rgba(139,92,246,0.08),transparent 70%);
              pointer-events:none;z-index:0;"></div>
  <div style="position:fixed;top:30%;right:-100px;width:400px;height:400px;
              background:radial-gradient(circle,rgba(6,182,212,0.06),transparent 70%);
              pointer-events:none;z-index:0;"></div>

  <!-- Navbar -->
  <nav class="lms-navbar navbar navbar-expand-lg">
    <div class="container">
      <a class="navbar-brand" href="#">⚡ LearnX</a>
      <div class="ms-auto d-flex gap-2">
        <a href="${pageContext.request.contextPath}/login"
           class="btn-secondary-custom"
           style="text-decoration:none;padding:0.5rem 1.25rem;
                  border-radius:var(--radius-sm);font-size:0.875rem;">
          Sign In
        </a>
        <a href="${pageContext.request.contextPath}/register"
           class="btn-primary-custom"
           style="text-decoration:none;padding:0.5rem 1.25rem;font-size:0.875rem;">
          Get Started
        </a>
      </div>
    </div>
  </nav>

  <div class="content-layer">

    <!-- Hero -->
    <section class="hero-section" style="padding:6rem 0 5rem;">
      <div class="container">
        <div class="hero-badge animate-slideUp">
          <i class="bi bi-stars"></i> Next-Gen Learning Platform
        </div>
        <h1 class="hero-title animate-slideUp stagger-1">
          Learn Smarter,<br/>
          Grow <span class="text-gradient">Faster</span>
        </h1>
        <p class="hero-subtitle animate-slideUp stagger-2">
          LearnX delivers world-class education through expert-led courses,
          interactive lessons, and real-time progress tracking.
          Your journey to mastery starts here.
        </p>
        <div class="d-flex gap-3 justify-content-center flex-wrap animate-slideUp stagger-3">
          <a href="${pageContext.request.contextPath}/register"
             class="btn-primary-custom" style="text-decoration:none;font-size:1rem;
                    padding:0.875rem 2rem;">
            Start Learning Free <i class="bi bi-arrow-right ms-2"></i>
          </a>
          <a href="${pageContext.request.contextPath}/courses"
             class="btn-secondary-custom" style="text-decoration:none;font-size:1rem;
                    padding:0.875rem 2rem;">
            <i class="bi bi-play-circle me-2"></i>Browse Courses
          </a>
        </div>

        <!-- Stats -->
        <div class="stats-strip mt-5 animate-slideUp stagger-4">
          <div class="stat-item">
            <div class="stat-number">10K+</div>
            <div class="stat-label">Students</div>
          </div>
          <div style="width:1px;background:var(--border-subtle);"></div>
          <div class="stat-item">
            <div class="stat-number">500+</div>
            <div class="stat-label">Courses</div>
          </div>
          <div style="width:1px;background:var(--border-subtle);"></div>
          <div class="stat-item">
            <div class="stat-number">50+</div>
            <div class="stat-label">Instructors</div>
          </div>
          <div style="width:1px;background:var(--border-subtle);"></div>
          <div class="stat-item">
            <div class="stat-number">98%</div>
            <div class="stat-label">Satisfaction</div>
          </div>
        </div>
      </div>
    </section>

    <!-- Features -->
    <section style="padding:4rem 0;">
      <div class="container">
        <div class="text-center mb-5 animate-slideUp">
          <div class="hero-badge" style="margin-bottom:0.75rem;">
            <i class="bi bi-lightning-charge"></i> Why LearnX
          </div>
          <h2 class="section-title">Everything You Need to Excel</h2>
          <p style="color:var(--text-secondary);max-width:480px;margin:0.75rem auto 0;">
            Built for modern learners who demand the best tools and experience.
          </p>
        </div>

        <div class="row g-4">
          <!-- Feature 1 -->
          <div class="col-12 col-md-6 col-lg-4 animate-slideUp stagger-1">
            <div class="lms-card" style="padding:2rem;height:100%;">
              <div style="width:52px;height:52px;border-radius:var(--radius-md);
                          background:rgba(99,102,241,0.15);display:flex;
                          align-items:center;justify-content:center;
                          font-size:1.5rem;margin-bottom:1.25rem;">🎯</div>
              <h5 style="font-family:var(--font-display);font-weight:600;
                         color:var(--text-primary);margin-bottom:0.625rem;">
                Expert-Led Courses
              </h5>
              <p style="color:var(--text-secondary);font-size:0.9rem;line-height:1.7;margin:0;">
                Learn from industry professionals with real-world experience.
                Structured paths from beginner to advanced.
              </p>
            </div>
          </div>

          <!-- Feature 2 -->
          <div class="col-12 col-md-6 col-lg-4 animate-slideUp stagger-2">
            <div class="lms-card" style="padding:2rem;height:100%;">
              <div style="width:52px;height:52px;border-radius:var(--radius-md);
                          background:rgba(6,182,212,0.15);display:flex;
                          align-items:center;justify-content:center;
                          font-size:1.5rem;margin-bottom:1.25rem;">📊</div>
              <h5 style="font-family:var(--font-display);font-weight:600;
                         color:var(--text-primary);margin-bottom:0.625rem;">
                Progress Tracking
              </h5>
              <p style="color:var(--text-secondary);font-size:0.9rem;line-height:1.7;margin:0;">
                Visual progress bars and completion tracking keep you
                motivated and focused on your learning goals.
              </p>
            </div>
          </div>

          <!-- Feature 3 -->
          <div class="col-12 col-md-6 col-lg-4 animate-slideUp stagger-3">
            <div class="lms-card" style="padding:2rem;height:100%;">
              <div style="width:52px;height:52px;border-radius:var(--radius-md);
                          background:rgba(16,185,129,0.15);display:flex;
                          align-items:center;justify-content:center;
                          font-size:1.5rem;margin-bottom:1.25rem;">🏆</div>
              <h5 style="font-family:var(--font-display);font-weight:600;
                         color:var(--text-primary);margin-bottom:0.625rem;">
                Earn Certificates
              </h5>
              <p style="color:var(--text-secondary);font-size:0.9rem;line-height:1.7;margin:0;">
                Complete courses and earn verified certificates to showcase
                your skills to employers and peers.
              </p>
            </div>
          </div>

          <!-- Feature 4 -->
          <div class="col-12 col-md-6 col-lg-4 animate-slideUp stagger-4">
            <div class="lms-card" style="padding:2rem;height:100%;">
              <div style="width:52px;height:52px;border-radius:var(--radius-md);
                          background:rgba(245,158,11,0.15);display:flex;
                          align-items:center;justify-content:center;
                          font-size:1.5rem;margin-bottom:1.25rem;">⚡</div>
              <h5 style="font-family:var(--font-display);font-weight:600;
                         color:var(--text-primary);margin-bottom:0.625rem;">
                Self-Paced Learning
              </h5>
              <p style="color:var(--text-secondary);font-size:0.9rem;line-height:1.7;margin:0;">
                Learn at your own speed. Pause, rewind, and revisit lessons
                anytime, anywhere, on any device.
              </p>
            </div>
          </div>

          <!-- Feature 5 -->
          <div class="col-12 col-md-6 col-lg-4 animate-slideUp stagger-5">
            <div class="lms-card" style="padding:2rem;height:100%;">
              <div style="width:52px;height:52px;border-radius:var(--radius-md);
                          background:rgba(139,92,246,0.15);display:flex;
                          align-items:center;justify-content:center;
                          font-size:1.5rem;margin-bottom:1.25rem;">🔒</div>
              <h5 style="font-family:var(--font-display);font-weight:600;
                         color:var(--text-primary);margin-bottom:0.625rem;">
                Secure Platform
              </h5>
              <p style="color:var(--text-secondary);font-size:0.9rem;line-height:1.7;margin:0;">
                BCrypt password hashing, session management, and role-based
                access keep your account safe.
              </p>
            </div>
          </div>

          <!-- Feature 6 -->
          <div class="col-12 col-md-6 col-lg-4 animate-slideUp stagger-6">
            <div class="lms-card" style="padding:2rem;height:100%;">
              <div style="width:52px;height:52px;border-radius:var(--radius-md);
                          background:rgba(239,68,68,0.15);display:flex;
                          align-items:center;justify-content:center;
                          font-size:1.5rem;margin-bottom:1.25rem;">📱</div>
              <h5 style="font-family:var(--font-display);font-weight:600;
                         color:var(--text-primary);margin-bottom:0.625rem;">
                Fully Responsive
              </h5>
              <p style="color:var(--text-secondary);font-size:0.9rem;line-height:1.7;margin:0;">
                Optimized for desktop, tablet, and mobile. Your learning
                experience is seamless on every screen size.
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA -->
    <section style="padding:5rem 0;">
      <div class="container">
        <div class="lms-card text-center animate-slideUp"
             style="padding:4rem 2rem;background:linear-gradient(135deg,
                    rgba(99,102,241,0.12),rgba(139,92,246,0.08));
                    border-color:rgba(99,102,241,0.2);
                    animation:pulse-glow 3s ease-in-out infinite;">
          <h2 style="font-family:var(--font-display);font-size:2.25rem;
                     font-weight:700;color:var(--text-primary);margin-bottom:1rem;">
            Ready to Start Your Journey?
          </h2>
          <p style="color:var(--text-secondary);font-size:1.05rem;
                    max-width:440px;margin:0 auto 2rem;">
            Join thousands of learners already growing with LearnX.
            Your first course is completely free.
          </p>
          <a href="${pageContext.request.contextPath}/register"
             class="btn-primary-custom"
             style="text-decoration:none;font-size:1rem;padding:0.875rem 2.5rem;">
            Create Free Account <i class="bi bi-arrow-right ms-2"></i>
          </a>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer style="border-top:1px solid var(--border-subtle);
                   padding:2rem 0;text-align:center;">
      <div class="container">
        <div class="mb-2">
          <span style="font-family:var(--font-display);font-weight:700;
                       background:var(--grad-primary);-webkit-background-clip:text;
                       -webkit-text-fill-color:transparent;background-clip:text;">
            ⚡ LearnX
          </span>
        </div>
        <p style="color:var(--text-muted);font-size:0.825rem;margin:0;">
          © 2026 LearnX LMS — Built with Java · Servlet · JSP · Oracle 19c · HikariCP
        </p>
      </div>
    </footer>

  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>