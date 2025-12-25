<%-- 
    Document   : index
    Created on : Dec 25, 2025, 8:33:50 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <body>
        <main>
            <!-- Login/Sign Up -->
            <div class="card">
                <img class="card__logo" src="${pageContext.request.contextPath}/assets/image/uitm_logo.png" alt="UiTM Logo">
                <div class="card__title">
                    <h1>Welcome to UiTM eCEMS 👋🏻</h1>
                    <p>Please sign-up new account for new user or sign-in your existing account.</p>
                </div>
                <div class="card__button__container">
                    <button class="card__button" onclick="location.href='${pageContext.request.contextPath}/login'">Sign In</button>
                    <div class="divider">
                        <hr class="hr-divider">
                        <p>or</p>
                        <hr class="hr-divider">
                    </div>
                    <button class="card__button" onclick="location.href='${pageContext.request.contextPath}/register'">Sign Up</button>
                </div>
            </div>
            <!-- End Login/Sign Up -->

            <!-- Banner -->
            <div class="banner">
                <img src="${pageContext.request.contextPath}/assets/image/banner.png" alt="Banner">
            </div>
            <!-- End Banner -->
        </main>
    </body>

</html>
