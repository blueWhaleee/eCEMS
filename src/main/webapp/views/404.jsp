<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="404 - Page Not Found" />

    <body style="background-color: #F3F9FE;">
        <div class="vh-100 d-flex align-items-center justify-content-center">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-6 text-center">
                        <div class="mb-4">
                            <svg width="120" height="120" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <circle cx="12" cy="12" r="11" stroke="#4c3d99" stroke-width="1.5"/>
                                <path d="M8 15C8.5 13.5 10 12.5 12 12.5C14 12.5 15.5 13.5 16 15" stroke="#4c3d99" stroke-width="1.5" stroke-linecap="round"/>
                                <circle cx="9" cy="9.5" r="1" fill="#1e1b4b"/>
                                <circle cx="15" cy="9.5" r="1" fill="#1e1b4b"/>
                            </svg>
                        </div>

                        <h1 class="display-1 fw-bold mb-0" style="color: #1e1b4b;">404</h1>
                        <h2 class="h4 fw-bold mb-3" style="color: #2d2a5a;">Oops! Page not found</h2>
                        <p class="text-secondary mb-5 px-md-5">
                            The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.
                        </p>

                        <a href="${pageContext.request.contextPath}/" 
                           class="btn btn-primary rounded-pill px-5 py-3 fw-semibold shadow-sm"
                           style="background: linear-gradient(135deg, #4c3d99 0%, #5b4fc9 100%); border: none; transition: transform 0.2s;"
                           onmouseover="this.style.transform='scale(1.05)'" 
                           onmouseout="this.style.transform='scale(1)'">
                            Back to Dashboard
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>
    </body>
</html>