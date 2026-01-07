<%-- 
    Document   : index
    Created on : Dec 25, 2025, 8:33:50 PM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Home" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <body>
        <main class="container-fluid p-0 vh-100 overflow-hidden">
            <div class="row g-0 h-100">
                
                <div class="col-lg-4 col-xl-4 bg-white p-4 p-md-5 d-flex flex-column justify-content-center align-items-center">
                    
                    <img class="mb-4" src="${pageContext.request.contextPath}/assets/image/uitm_logo.png" 
                        alt="UiTM Logo" style="width: 10rem;">
                    
                    <div class="w-100 mb-4">
                        <h1 class="h4 fw-bold">Welcome to UiTM eCEMS 👋🏻</h1>
                        <p class="text-secondary small">Please sign-up new account for new user or sign-in your existing account.</p>
                    </div>

                    <div class="w-100">
                        <button class="btn btn-primary w-100 py-2 shadow-sm" 
                                onclick="location.href='${pageContext.request.contextPath}/login'">
                            Sign In
                        </button>

                        <div class="d-flex align-items-center my-4">
                            <hr class="flex-grow-1 m-0">
                            <span class="mx-2 text-primary-muted">or</span>
                            <hr class="flex-grow-1 m-0">
                        </div>

                        <button class="btn btn-primary w-100 py-2 shadow-sm" 
                                onclick="location.href='${pageContext.request.contextPath}/register'">
                            Sign Up
                        </button>
                    </div>
                </div>
                <div class="col-lg-8 col-xl-8 d-none d-lg-flex bg-primary-subtle justify-content-center align-items-center p-5">
                    <img src="${pageContext.request.contextPath}/assets/image/banner.png" 
                        alt="Banner" class="img-fluid" style="max-height: 80vh;">
                </div>
                </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>
