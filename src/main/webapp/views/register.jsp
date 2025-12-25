<%-- 
    Document   : register
    Created on : Dec 25, 2025, 9:49:40 PM
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
                    <p>Sign up account for new user</p>
                </div>

                <!-- Login Form -->
                <form class="card__form" action="${pageContext.request.contextPath}/register" method="POST">
                    <div>
                        <label for="email">Email</label>
                        <input name="email" type="text" placeholder="Enter your email">
                    </div>
                    <div>
                        <label for="full_name">Full Name</label>
                        <input name="full_name" type="text" placeholder="Enter your name">
                    </div>
                    <div>
                        <label for="stud_number">Student Number</label>
                        <input name="stud_number" type="text" placeholder="Enter your Student Number">
                    </div>
                    <div>
                        <label for="password">Password</label>
                        <input name="password" type="password" placeholder="············">
                    </div>
                    <div>
                        <label for="campus_id">Campus</label>
                        <select name="campus_id">
                            <option value='-1'>Select Campus</option>
                            <option value='1'>Kampus Shah Alam</option>
                        </select>
                    </div>
                    <div>
                        <label for="faculty_id">Faculty</label>
                        <select name="faculty_id">
                            <option value='-1'>Select Faculty</option>
                            <option value='1'>Faculty of Computer and Mathematical Science</option>
                        </select>
                    </div>
                    <div class="card__button__container">
                        <button class="card__button" onclick="location.href='login.html'">Sign Up</button>
                    </div>
                </form>
                <!-- End Login Form-->

                <p class="card__footer">
                    Already have an account?
                    <a href="${pageContext.request.contextPath}/login">Sign in instead</a>
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
