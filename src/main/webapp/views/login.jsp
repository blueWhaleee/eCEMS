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
        <main>
            <!-- Login/Sign Up -->
            <div class="card">
                <img class="card__logo" src="${pageContext.request.contextPath}/assets/image/uitm_logo.png" alt="UiTM Logo">
                <div class="card__title">
                    <h1>Welcome to UiTM eCEMS 👋🏻</h1>
                    <p>Sign in into your account</p>
                </div>

                <!-- Login Form -->
                <form class="card__form" action="${pageContext.request.contextPath}/login" method="POST">
                    <div>
                        <label for="studentNo">Student No.</label>
                        <input name="" type="text" placeholder="Enter your Student No.">
                    </div>
                    <div>
                        <label for="password">Password</label>
                        <input name="" type="password" placeholder="············">
                    </div>
                    <div class="card__button__container">
                        <button class="card__button" type="submit">Sign In</button>
                    </div>
                </form>
                <!-- End Login Form-->

                <p class="card__footer">
                    New on our platform?
                    <a href="${pageContext.request.contextPath}/register">Create an account</a>
                </p>
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
