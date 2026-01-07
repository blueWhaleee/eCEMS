<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.ecems.model.User"%>
<%
    User usr = (User) session.getAttribute("loggedInUser");
    
    if (usr == null)
    {
        response.sendRedirect("login.jsp");
        return;
    }
    
    if (!"Staff".equals(usr.getRole()))
    {
        response.sendRedirect("home.jsp");
        return;
    }
%>

<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
<html>

<head>
    <title>eCEMS | Elections</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/nav.css" type="text/css">
    <link rel="stylesheet" href="css/create_elections.css" type="text/css">
    <link rel="stylesheet" href="https://cdn.datatables.net/2.1.8/css/dataTables.dataTables.min.css">
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
                <li onclick="location.href='home_staff.jsp'" class="menu__button-item">
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
                <li onclick="location.href='create_elections.jsp'" class="menu__button-item">
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
                <li onclick="location.href='reports.jsp'" class="menu__button-item menu__button-active">
                    <svg width="36" height="36" viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M13.5 7.5H10.5C8.84315 7.5 7.5 8.84315 7.5 10.5V28.5C7.5 30.1569 8.84315 31.5 10.5 31.5H25.5C27.1569 31.5 28.5 30.1569 28.5 28.5V10.5C28.5 8.84315 27.1569 7.5 25.5 7.5H22.5" stroke="white" stroke-opacity="0.9" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        <rect x="13.5" y="4.5" width="9" height="6" rx="2" stroke="white" stroke-opacity="0.9" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M13.5001 18H13.5151" stroke="white" stroke-opacity="0.9" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M19.5 18H22.5" stroke="white" stroke-opacity="0.9" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M13.5001 24H13.5151" stroke="white" stroke-opacity="0.9" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M19.5 24H22.5" stroke="white" stroke-opacity="0.9" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <p>Reports</p>
                    <!-- need to check and think again -->
                        <div class="main__container__messagebox" style="margin-top: 2rem;">
                            <h2>Reports Dashboard</h2>
                            <p>Election statistics and analytics will appear here</p>
                            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-top: 1rem;">
                                <div style="background: white; padding: 1rem; border-radius: 8px;">
                                    <h3>Voter Turnout</h3>
                                    <p>Coming soon...</p>
                                </div>
                                <div style="background: white; padding: 1rem; border-radius: 8px;">
                                    <h3>Election Results</h3>
                                    <p>Coming soon...</p>
                                </div>
                            </div>
                        </div>
                </li>
            </ul>

            <div class="menu__profile">
                <div class="menu__profile__image">
                    <img src="./image/profile_img.png" alt="Profile Image">
                </div>
                <p> <%= usr.getStudentNo() %> </p>
                <div class="menu__profile__role">
                    <%= usr.getRole() %>
                </div>
                <button onclick="location.href='logout.jsp'">Logout</button>
            </div>

        </nav>
        <!-- End Navigation Bar -->

        <!-- Main -->
        <main class="main">
            <div class="main__container">
                <h1>Reports</h1>

            </div>
        </main>
        <!-- End Main -->
    </div>
</body>
</html>