<%-- 
    Document   : index
    Created on : Dec 25, 2025, 9:56:32 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <body>
        <div class="container">

            <!-- Navigation bar -->
            <nav class="menu">
                <div class="menu__logo">
                    <img src="${pageContext.request.contextPath}/assets/image/jpjpp_logo.png" alt="JPJPP Logo">
                    <p>eCEMS</p>
                </div>

                <ul class="menu__button">
                    <li onclick="location.href='home.html'" class="menu__button-item menu__button-active">
                        <svg width="29" height="29" viewBox="0 0 29 29" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M3.75 14.25H0.75L14.25 0.75L27.75 14.25H24.75" stroke="white" stroke-width="1.5"
                                stroke-linecap="round" stroke-linejoin="round" />
                            <path
                                d="M3.75 14.25V24.75C3.75 26.4069 5.09315 27.75 6.75 27.75H21.75C23.4069 27.75 24.75 26.4069 24.75 24.75V14.25"
                                stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" />
                            <path
                                d="M9.75 27.75V18.75C9.75 17.0931 11.0931 15.75 12.75 15.75H15.75C17.4069 15.75 18.75 17.0931 18.75 18.75V27.75"
                                stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                        <p>Home</p>
                    </li>
                    <li onclick="location.href='elections.html'" class="menu__button-item">
                        <svg width="36" height="36" viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path
                                d="M17.6925 31.5H7.5C5.84315 31.5 4.5 30.1569 4.5 28.5V10.5C4.5 8.84315 5.84315 7.5 7.5 7.5H25.5C27.1569 7.5 28.5 8.84315 28.5 10.5V16.5"
                                stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" />
                            <circle cx="27" cy="27" r="6" stroke="white" stroke-width="1.5" stroke-linecap="round"
                                stroke-linejoin="round" />
                            <path d="M22.5 4.5V10.5" stroke="white" stroke-width="1.5" stroke-linecap="round"
                                stroke-linejoin="round" />
                            <path d="M10.5 4.5V10.5" stroke="white" stroke-width="1.5" stroke-linecap="round"
                                stroke-linejoin="round" />
                            <path d="M4.5 16.5H28.5" stroke="white" stroke-width="1.5" stroke-linecap="round"
                                stroke-linejoin="round" />
                            <path d="M27 24.744V27L28.5 28.5" stroke="white" stroke-width="1.5" stroke-linecap="round"
                                stroke-linejoin="round" />
                        </svg>
                        <p>Elections</p>
                    </li>
                </ul>

                <div class="menu__profile">
                    <div class="menu__profile__image">
                        <img src="${pageContext.request.contextPath}/assets/image/profile_img.png" alt="Profile Image">
                    </div>
                    <p>2025148599</p>
                    <div class="menu__profile__role">
                        Student
                    </div>
                    <button onclick="location.href='index.html'">Logout</button>
                </div>

            </nav>
            <!-- End Navigation Bar -->

            <!-- Main -->
            <main class="main">
                <div class="main__container">
                    <h1>Home</h1>

                    <!-- Message Box -->
                    <div class="main__container__messagebox">
                        <h2>Welcome Back,</h2>
                        <p>Amer Syafiq bin Abdul Razak</p>
                        <img src="${pageContext.request.contextPath}/assets/image/home_logo.svg" alt="">
                    </div>
                    <!-- End Message Box -->

                    <!-- Recent Votes -->
                    <div class="main__container__recent">
                        <h3>Recent Votes</h3>

                        <!-- Table -->
                        <table class="main__container__table">
                            <thead>
                                <tr>
                                    <th>ELECTIONS</th>
                                    <th>VOTE</th>
                                    <th>DATE</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><div>Jawatankuasa Perwakilan Pelajar Fakulti Sains Komputer dan Matematik</div></td>
                                    <td><div>Ali bin Abu</div></td>
                                    <td><div>10, Jan 2020 20:07</div></td>
                                </tr>
                                <tr>
                                    <td><div>Jawatankuasa Perwakilan Kolej UiTM Shah Alam</div></td>
                                    <td><div>Ghana</div></td>
                                    <td><div>11, Jan 2020 10:16</div></td>
                                </tr>
                                <tr>
                                    <td><div>Jawatankuasa Perwakilan Pelajar Fakulti Sains Komputer dan Matematik</div></td>
                                    <td><div>Ali bin Abu</div></td>
                                    <td><div>10, Jan 2020 20:07</div></td>
                                </tr>
                                <tr>
                                    <td><div>Jawatankuasa Perwakilan Kolej UiTM Shah Alam</div></td>
                                    <td><div>Ghana</div></td>
                                    <td><div>11, Jan 2020 10:16</div></td>
                                </tr>
                                <tr>
                                    <td><div>Jawatankuasa Perwakilan Pelajar Fakulti Sains Komputer dan Matematik</div></td>
                                    <td><div>Ali bin Abu</div></td>
                                    <td><div>10, Jan 2020 20:07</div></td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- End Table -->
                    </div>
                    <!-- End Recent Votes -->

                    <!-- Elections Button -->
                    <div class="main__container__button">
                        <div>
                            <h3>View Elections</h2>
                            <p>Vote in elections or register as candidate</p>
                        </div>
                        <button onclick="location.href='elections.html'">
                            Elections
                        </button>
                    </div>
                    <!-- End Elections Button -->

                </div>
                <div class="main__side">
                    <h3>Statistics</h3>
                </div>
            </main>
            <!-- End Main -->
        </div>
    </body>
</html>
