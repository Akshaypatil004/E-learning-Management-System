<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Error — LearnX LMS</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet"/>
</head>
<body class="bg-mesh">

  <!-- Background Orbs -->
  <div style="position:fixed;top:-200px;left:-200px;width:600px;height:600px;
              background:radial-gradient(circle,rgba(239,68,68,0.08),transparent 70%);
              pointer-events:none;z-index:0;"></div>
  <div style="position:fixed;bottom:-200px;right:-200px;width:600px;height:600px;
              background:radial-gradient(circle,rgba(99,102,241,0.08),transparent 70%);
              pointer-events:none;z-index:0;"></div>

  <div class="content-layer" style="min-height:100vh;display:flex;
       align-items:center;justify-content:center;padding:2rem;">
    <div class="text-center animate-slideUp" style="max-width:480px;">

      <!-- Error Code -->
      <div style="font-family:var(--font-display);font-size:7rem;font-weight:700;
                  line-height:1;background:linear-gradient(135deg,#ef4444,#8b5cf6);
                  -webkit-background-clip:text;-webkit-text-fill-color:transparent;
                  background-clip:text;margin-bottom:0.5rem;
                  animation:float 3s ease-in-out infinite;">
        <%
          Integer statusCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");
          out.print(statusCode != null ? statusCode : "Oops");
        %>
      </div>

      <!-- Icon -->
      <div style="font-size:3.5rem;margin-bottom:1.5rem;">
        <%
          if (statusCode != null && statusCode == 404) {
        %>
          🔍
        <% } else { %>
          ⚠️
        <% } %>
      </div>

      <!-- Title -->
      <h2 style="font-family:var(--font-display);font-weight:700;
                 color:var(--text-primary);margin-bottom:0.75rem;">
        <%
          if (statusCode != null && statusCode == 404) {
        %>
          Page Not Found
        <% } else { %>
          Something Went Wrong
        <% } %>
      </h2>

      <!-- Message -->
      <p style="color:var(--text-secondary);font-size:1rem;
                line-height:1.7;margin-bottom:2rem;">
        <%
          if (statusCode != null && statusCode == 404) {
        %>
          The page you're looking for doesn't exist or has been moved.
          Let's get you back on track.
        <% } else { %>
          An unexpected error occurred. Our team has been notified.
          Please try again or return to the dashboard.
        <% } %>
      </p>

      <!-- Actions -->
      <div class="d-flex gap-3 justify-content-center flex-wrap">
        <a href="${pageContext.request.contextPath}/dashboard"
           class="btn-primary-custom" style="text-decoration:none;">
          <i class="bi bi-grid me-2"></i>Go to Dashboard
        </a>
        <a href="javascript:history.back()"
           class="btn-secondary-custom" style="text-decoration:none;">
          <i class="bi bi-arrow-left me-2"></i>Go Back
        </a>
      </div>

      <!-- Brand -->
      <div style="margin-top:3rem;">
        <a href="${pageContext.request.contextPath}/dashboard"
           style="font-family:var(--font-display);font-size:1.1rem;font-weight:700;
                  background:var(--grad-primary);-webkit-background-clip:text;
                  -webkit-text-fill-color:transparent;background-clip:text;
                  text-decoration:none;">
          ⚡ LearnX
        </a>
      </div>

    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>