<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="com.ecems.model.User" %>
<%
    User usr = (User) session.getAttribute("loggedInUser");
    
    if(usr == null)
    {
        response.sendRedirect("login.jsp");
        return;
    }
    
    if (!"Staff".equalsIgnoreCase(usr.getRole()))
    {
        response.sendRedirect("home.jsp");
    }
%>

<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
<html>

<head>
    <title>eCEMS | Home</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/nav.css" type="text/css">
    <link rel="stylesheet" href="css/home.css" type="text/css">
</head>

<body>
    <div class="container">

        <!-- Navigation bar -->
        <nav class="menu">
            <div class="menu__logo">
                <img src="./image/jpjpp_logo.png" alt="JPJPP Logo">
                <p>eCEMS</p>
            </div>

            <ul class="menu__button">
                <li onclick="location.href='home_staff.html'" class="menu__button-item menu__button-active">
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
                <li onclick="location.href='create_elections.html'" class="menu__button-item">
                    <svg width="36" height="36" viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="6" y="7.5" width="24" height="24" rx="2" stroke="#E1DEF5" stroke-opacity="0.9" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M24 4.5V10.5" stroke="#E1DEF5" stroke-opacity="0.9" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M12 4.5V10.5" stroke="#E1DEF5" stroke-opacity="0.9" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M6 16.5H30" stroke="#E1DEF5" stroke-opacity="0.9" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M15 24H21" stroke="#E1DEF5" stroke-opacity="0.9" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M18 21V27" stroke="#E1DEF5" stroke-opacity="0.9" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <p>Create <br>Elections</p>
                </li>
                <li onclick="location.href='reports.html'" class="menu__button-item">
                    <svg width="36" height="36" viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M13.5 7.5H10.5C8.84315 7.5 7.5 8.84315 7.5 10.5V28.5C7.5 30.1569 8.84315 31.5 10.5 31.5H25.5C27.1569 31.5 28.5 30.1569 28.5 28.5V10.5C28.5 8.84315 27.1569 7.5 25.5 7.5H22.5" stroke="white" stroke-opacity="0.9" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        <rect x="13.5" y="4.5" width="9" height="6" rx="2" stroke="white" stroke-opacity="0.9" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M13.5001 18H13.5151" stroke="white" stroke-opacity="0.9" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M19.5 18H22.5" stroke="white" stroke-opacity="0.9" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M13.5001 24H13.5151" stroke="white" stroke-opacity="0.9" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M19.5 24H22.5" stroke="white" stroke-opacity="0.9" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <p>Reports</p>
                </li>
            </ul>

            <div class="menu__profile">
                <div class="menu__profile__image">
                    <img src="./image/profile_img.png" alt="Profile Image">
                </div>
                <p> <%=  usr.getStudentNo() %> </p>
                <div class="menu__profile__role">
                    <%= usr.getRole() %>
                </div>
                <button onclick="location.href='NavigationServlelt?page=logout'">Logout</button>
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
                    <p> <%= usr.getFullName() %> </p>
                    <img src="./image/home_logo.svg" alt="">
                </div>
                <!-- End Message Box -->

                <div class="main__container__data">
                    <div class="main__container__data-item">
                        <h1>6</h1>
                        <div>
                            <h3>Students</h3>
                            <p>Registered</p>
                        </div>
                    </div>
                    <div class="main__container__data-item">
                        <h1>12</h1>
                        <div>
                            <h3>Staff</h3>
                            <p>Registered</p>
                        </div>
                    </div>
                    <div class="main__container__data-item">
                        <h1>24</h1>
                        <div>
                            <h3>Elections</h3>
                            <p>Created</p>
                        </div>
                    </div>
                </div>

                <!-- Active Elections -->
                <div class="main__container__recent">
                    <h3>Active Elections</h3>

                    <!-- Table -->
                    <table class="main__container__table">
                        <thead>
                            <tr>
                                <th>ELECTIONS</th>
                                <th>NUMBER OF CANDIDATES</th>
                                <th>DATE</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><div>Jawatankuasa Perwakilan Pelajar Fakulti Sains Komputer dan Matematik</div></td>
                                <td><div>3</div></td>
                                <td><div>10, Jan 2020 20:07</div></td>
                            </tr>
                            <tr>
                                <td><div>Jawatankuasa Perwakilan Kolej UiTM Shah Alam</div></td>
                                <td><div>4</div></td>
                                <td><div>11, Jan 2020 10:16</div></td>
                            </tr>
                            <tr>
                                <td><div>Jawatankuasa Perwakilan Pelajar Fakulti Sains Komputer dan Matematik</div></td>
                                <td><div>3</div></td>
                                <td><div>10, Jan 2020 20:07</div></td>
                            </tr>
                            <tr>
                                <td><div>Jawatankuasa Perwakilan Kolej UiTM Shah Alam</div></td>
                                <td><div>4</div></td>
                                <td><div>11, Jan 2020 10:16</div></td>
                            </tr>
                            <tr>
                                <td><div>Jawatankuasa Perwakilan Pelajar Fakulti Sains Komputer dan Matematik</div></td>
                                <td><div>3</div></td>
                                <td><div>10, Jan 2020 20:07</div></td>
                            </tr>
                        </tbody>
                    </table>
                    <!-- End Table -->
                </div>
                <!-- End Recent Votes -->

                <!-- Elections Button -->
                <div class = "main_container__button-wrapper">
                    <div class="main__container__button">
                        <div>
                            <h3>View Elections</h2>
                            <p>View student elections</p>
                        </div>
                        <button onclick="location.href='elections.html'">
                            Elections
                        </button>
                    </div>

                    <div class="main__container__button">
                        <div>
                            <h3>Create Elections</h2>
                            <p>Create student elections</p>
                        </div>
                        <button onclick="location.href='create_elections.html'">
                            Create
                        </button>
                    </div>
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