<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Sign In — LearnX LMS</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet"/>
</head>
<body class="bg-mesh">

  <!-- Background Orbs -->
  <div style="position:fixed;top:-200px;left:-200px;width:600px;height:600px;
              background:radial-gradient(circle,rgba(99,102,241,0.12),transparent 70%);
              pointer-events:none;z-index:0;"></div>
  <div style="position:fixed;bottom:-200px;right:-200px;width:600px;height:600px;
              background:radial-gradient(circle,rgba(139,92,246,0.10),transparent 70%);
              pointer-events:none;z-index:0;"></div>

  <div class="auth-wrapper content-layer">
    <div class="auth-card animate-slideUp">

      <!-- Logo -->
      <div class="text-center mb-4">
        <div class="auth-logo">⚡ LearnX</div>
        <p class="auth-subtitle">Welcome back — continue your learning journey</p>
      </div>

      <!-- Error Alert -->
      <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="lms-alert lms-alert-danger">
          <i class="bi bi-exclamation-circle-fill"></i>
          ${errorMessage}
        </div>
      <% } %>

      <!-- Login Form -->
      <form action="${pageContext.request.contextPath}/login" method="post">

        <div class="lms-form-group">
          <label class="lms-label">Email Address</label>
          <input type="email" name="email" class="lms-input"
                 placeholder="you@example.com" required autofocus/>
        </div>

        <div class="lms-form-group">
          <label class="lms-label">Password</label>
          <div style="position:relative;">
            <input type="password" name="password" id="passwordInput" class="lms-input"
                   placeholder="Enter your password" required
                   style="padding-right:3rem;"/>
            <button type="button" onclick="togglePassword()"
                    style="position:absolute;right:1rem;top:50%;transform:translateY(-50%);
                           background:none;border:none;color:var(--text-muted);cursor:pointer;
                           font-size:1rem;">
              <i class="bi bi-eye" id="eyeIcon"></i>
            </button>
          </div>
        </div>

        <div class="lms-form-group">
          <label class="lms-label">Sign in as</label>
          <select name="role" class="lms-input lms-select" required>
            <option value="" disabled selected>Select your role</option>
            <option value="student">🎓 Student</option>
            <option value="instructor">👨‍🏫 Instructor</option>
            <option value="admin">🛡️ Admin</option>
          </select>
        </div>

        <button type="submit" class="btn-primary-custom w-100 mt-2">
          <i class="bi bi-box-arrow-in-right me-2"></i>Sign In
        </button>

      </form>

      <div class="auth-divider">or</div>

      <div class="text-center">
        <span style="color:var(--text-secondary);font-size:0.9rem;">
          New to LearnX?
        </span>
        <a href="${pageContext.request.contextPath}/register"
           style="color:var(--color-primary);font-weight:600;
                  text-decoration:none;margin-left:0.375rem;">
          Create account <i class="bi bi-arrow-right"></i>
        </a>
      </div>

    </div>
  </div>

  <script>
    function togglePassword() {
      const input   = document.getElementById('passwordInput');
      const icon    = document.getElementById('eyeIcon');
      const isPass  = input.type === 'password';
      input.type    = isPass ? 'text' : 'password';
      icon.className = isPass ? 'bi bi-eye-slash' : 'bi bi-eye';
    }
  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>