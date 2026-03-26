<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Create Account — LearnX LMS</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet"/>
</head>
<body class="bg-mesh">

  <!-- Background Orbs -->
  <div style="position:fixed;top:-200px;right:-200px;width:600px;height:600px;
              background:radial-gradient(circle,rgba(139,92,246,0.12),transparent 70%);
              pointer-events:none;z-index:0;"></div>
  <div style="position:fixed;bottom:-200px;left:-200px;width:600px;height:600px;
              background:radial-gradient(circle,rgba(6,182,212,0.08),transparent 70%);
              pointer-events:none;z-index:0;"></div>

  <div class="auth-wrapper content-layer">
    <div class="auth-card animate-slideUp">

      <!-- Logo -->
      <div class="text-center mb-4">
        <div class="auth-logo">⚡ LearnX</div>
        <p class="auth-subtitle">Join thousands of learners and instructors today</p>
      </div>

      <!-- Register Form -->
      <form action="${pageContext.request.contextPath}/register" method="post">

        <div class="lms-form-group">
          <label class="lms-label">Full Name</label>
          <input type="text" name="name" class="lms-input"
                 placeholder="Your full name" required autofocus/>
        </div>

        <div class="lms-form-group">
          <label class="lms-label">Email Address</label>
          <input type="email" name="email" class="lms-input"
                 placeholder="you@example.com" required/>
        </div>

        <div class="lms-form-group">
          <label class="lms-label">Password</label>
          <div style="position:relative;">
            <input type="password" name="password" id="passwordInput" class="lms-input"
                   placeholder="Min. 8 characters" required minlength="8"
                   style="padding-right:3rem;"/>
            <button type="button" onclick="togglePassword()"
                    style="position:absolute;right:1rem;top:50%;transform:translateY(-50%);
                           background:none;border:none;color:var(--text-muted);
                           cursor:pointer;font-size:1rem;">
              <i class="bi bi-eye" id="eyeIcon"></i>
            </button>
          </div>
        </div>

        <!-- Password Strength -->
        <div style="margin-top:-0.75rem;margin-bottom:1.25rem;">
          <div class="lms-progress" style="height:4px;">
            <div class="lms-progress-bar" id="strengthBar" style="width:0%;"></div>
          </div>
          <span id="strengthLabel"
                style="font-size:0.75rem;color:var(--text-muted);margin-top:0.25rem;
                       display:block;"></span>
        </div>

        <div class="lms-form-group">
          <label class="lms-label">Register as</label>
          <select name="role" class="lms-input lms-select" required>
            <option value="" disabled selected>Select your role</option>
            <option value="student">🎓 Student</option>
            <option value="instructor">👨‍🏫 Instructor</option>
          </select>
        </div>

        <!-- Terms -->
        <div style="display:flex;align-items:flex-start;gap:0.75rem;margin-bottom:1.5rem;">
          <input type="checkbox" id="terms" required
                 style="margin-top:0.2rem;accent-color:var(--color-primary);
                        width:16px;height:16px;flex-shrink:0;"/>
          <label for="terms"
                 style="font-size:0.85rem;color:var(--text-secondary);cursor:pointer;">
            I agree to the
            <a href="#" style="color:var(--color-primary);text-decoration:none;">
              Terms of Service
            </a>
            and
            <a href="#" style="color:var(--color-primary);text-decoration:none;">
              Privacy Policy
            </a>
          </label>
        </div>

        <button type="submit" class="btn-primary-custom w-100">
          <i class="bi bi-person-plus me-2"></i>Create Account
        </button>

      </form>

      <div class="auth-divider">or</div>

      <div class="text-center">
        <span style="color:var(--text-secondary);font-size:0.9rem;">
          Already have an account?
        </span>
        <a href="${pageContext.request.contextPath}/login"
           style="color:var(--color-primary);font-weight:600;
                  text-decoration:none;margin-left:0.375rem;">
          Sign in <i class="bi bi-arrow-right"></i>
        </a>
      </div>

    </div>
  </div>

  <script>
    function togglePassword() {
      const input  = document.getElementById('passwordInput');
      const icon   = document.getElementById('eyeIcon');
      const isPass = input.type === 'password';
      input.type   = isPass ? 'text' : 'password';
      icon.className = isPass ? 'bi bi-eye-slash' : 'bi bi-eye';
    }

    document.getElementById('passwordInput').addEventListener('input', function () {
      const val = this.value;
      const bar = document.getElementById('strengthBar');
      const lbl = document.getElementById('strengthLabel');
      let strength = 0;
      if (val.length >= 8)               strength++;
      if (/[A-Z]/.test(val))             strength++;
      if (/[0-9]/.test(val))             strength++;
      if (/[^A-Za-z0-9]/.test(val))      strength++;
      const levels = [
        { w: '0%',   color: '',                        text: '' },
        { w: '25%',  color: 'var(--color-danger)',     text: 'Weak' },
        { w: '50%',  color: 'var(--color-warning)',    text: 'Fair' },
        { w: '75%',  color: 'var(--color-cyan)',       text: 'Good' },
        { w: '100%', color: 'var(--color-success)',    text: 'Strong' },
      ];
      bar.style.width      = levels[strength].w;
      bar.style.background = levels[strength].color;
      lbl.textContent      = levels[strength].text;
      lbl.style.color      = levels[strength].color;
    });
  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>