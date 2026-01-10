<%-- 
    Document   : login
    Created on : Dec 25, 2025, 9:41:21 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <body>
        <main class="container-fluid p-0 vh-100 overflow-hidden position-relative">
            <div class="row g-0 h-100">
                
                <div class="col-lg-4 col-xl-4 bg-white p-4 p-md-5 d-flex flex-column justify-content-center align-items-center">
                    
                    <img class="mb-4" src="${pageContext.request.contextPath}/assets/image/uitm_logo.png" 
                        alt="UiTM Logo" style="width: 10rem;">
                    
                    <div class="w-100 mb-3">
                        <h1 class="h4 fw-bold">Welcome to UiTM eCEMS 👋🏻</h1>
                        <p class="text-secondary small">Sign in into your account</p>
                    </div>

                    <form class="w-100" action="${pageContext.request.contextPath}/login" method="POST">
                        <div class="mb-3">
                            <label for="number" class="form-label small fw-semibold">Student/Staff No.</label>
                            <input name="number" type="text" class="form-control form-control-lg fs-6" placeholder="Enter your Student No." required>
                        </div>
                        <div class="mb-4">
                            <label for="password" class="form-label small fw-semibold">Password</label>
                            <input name="password" type="password" class="form-control form-control-lg fs-6" placeholder="············" required>
                        </div>
                        <div class="form-check form-switch mb-3">
                            <input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault" name="is_staff">
                            <label class="form-check-label" for="flexSwitchCheckDefault">Login as Staff</label>
                        </div>
                        
                        <button class="btn btn-primary w-100 py-2 shadow-sm mb-3" type="submit">Sign In</button>
                    </form>
                    <p class="small text-secondary">
                        New on our platform?
                        <a href="${pageContext.request.contextPath}/register" class="text-decoration-none fw-semibold">Create an account</a>
                    </p>
                </div>
                <div class="col-lg-8 col-xl-8 d-none d-lg-flex bg-primary-subtle justify-content-center align-items-center p-5">
                    <img src="${pageContext.request.contextPath}/assets/image/banner.png" 
                        alt="Banner" class="img-fluid" style="max-height: 80vh;">
                </div>
                </div>

            <c:if test="${not empty errors}">
                <div class="position-absolute bottom-0 end-0 p-3" style="z-index: 1050; width: 100%; max-width: 400px;">
                    <c:forEach var="err" items="${errors}">
                        <div class="alert alert-danger alert-dismissible fade show shadow-sm border-danger-subtle d-flex align-items-center" role="alert">
                            <div class="flex-grow-1">${err}</div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </main>
    </body>

    <%-- Javascripts  --%>
    <%@ include file="/WEB-INF/jspf/scripts.jspf" %>

    <script>
        $(document).ready(function() {
            $(document).on('click', '.btn-close', function() {
                var $alert = $(this).closest('.alert');
                
                $alert.removeClass('show');
                
                setTimeout(function() {
                    $alert.remove();
                }, 150);
            });
        });
    </script>
</html>
