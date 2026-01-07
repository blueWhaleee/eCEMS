<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.ecems.model.User"%>
<%
    User usr = (User) session.getAttribute("loggedInUser");
    
    if (usr == null)
    {
        response.sendRedirect("login.jsp");
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
    <title>eCEMS | Post</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/nav.css" type="text/css">
    <link rel="stylesheet" href="./css/post.css" type="text/css">
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
                <li onclick="location.href='./home.jsp'" class="menu__button-item">
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
                <li onclick="location.href='./elections.jsp'" class="menu__button-item menu__button-active">
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
                <h1>Post</h1>

                <!-- Return Button -->
                <button class="main__container__return" onclick="location.href='./elections.html'">
                    <svg width="20" height="22" viewBox="0 0 20 22" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M4.16675 10.9999H15.8334" stroke="#121026" stroke-width="1.5" stroke-linecap="round"
                            stroke-linejoin="round" />
                        <path d="M4.16675 11L9.16675 16" stroke="#121026" stroke-width="1.5" stroke-linecap="round"
                            stroke-linejoin="round" />
                        <path d="M4.16675 11L9.16675 6" stroke="#121026" stroke-width="1.5" stroke-linecap="round"
                            stroke-linejoin="round" />
                    </svg>
                    Return
                </button>
                <!-- End Return Button -->

                <!-- Election Post Title & Desc -->
                <div class="main__container__title">
                    <h1>Jawatankuasa Perwakilan Pelajar Fakulti Sains Komputer dan Matematik</h1>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ante mi, vehicula in tincidunt
                        a, dictum vitae tortor. In vitae lorem vel augue sagittis pulvinar nec sed massa. Nunc ut congue
                        diam, ut accumsan odio.</p>
                </div>
                <!-- End Election Post Title & Desc -->

                <!-- If Status = Upcoming -->
                <!-- Candidate Form -->
                <form class="main__container__form">
                    <div class="main__container__form-title">
                        <h3>Register as a Candidate</h3>
                        <p>Fill in the details below to complete your registration</p>
                    </div>
                    <div class="main__container__form-multi">
                        <div class="main__container__form-input">
                            <label for="">Full Name</label>
                            <input type="text" disabled value="<%= usr.getFullName() %>">
                        </div>
                        <div class="main__container__form-input">
                            <label for="">Student Number</label>
                            <input type="text" disabled value="<%= usr.getStudentNo() %>">
                        </div>
                    </div>
                    <div class="main__container__form-multi">
                        <div class="main__container__form-input">
                            <label for="">Faculty</label>
                            <input type="text" disabled value="CS - Faculty of Computer and Mathematical Sciences">
                        </div>
                        <div class="main__container__form-input">
                            <label for="">Program</label>
                            <input type="text" disabled value="CDCS230 - Bachelor of Computer Science (Hons.)">
                        </div>
                    </div>
                    <div class="main__container__form-input">
                        <label for="">Campaign Slogan</label>
                        <input type="text" value="">
                    </div>
                    <div class="main__container__form-input">
                        <label for="">Campaign Manifesto</label>
                        <textarea rows="3"></textarea>
                    </div>

                    <button>

                    </button>
                </form>
                <!-- End Candidate Form -->

                <!-- If Status = Active -->
                <!-- Show candidate -->
                <!-- End Show candidate -->

                <!-- If Status = Closed -->
                <!-- Show Result -->
                 <!-- End Show Result -->

            </div>


            <div class="main__side">
                <h3>Information</h3>

                <!-- Candidate Information -->
                <div class="main__side__data">
                    <h1>6</h1>
                    <div>
                        <h3>Students</h3>
                        <p>Registered Candidacy</p>
                    </div>
                </div>
                <!-- End Candidate Information -->

                <!-- Creator Information -->
                <div class="main__side__profile">
                    <div class="main__side__profile-user">
                        <p>Created By</p>
                        <div>
                            <div class="main__side__profile-user-img">
                                <img src="./image/profile_img.png" alt="">
                            </div>
                            <div class="main__side__profile-user-desc">
                                <h4>Election Administrator</h4>
                                <p>Staff</p>
                            </div>
                        </div>
                    </div>
                    <div class="main__side__profile-date">
                        <p>Created On</p>
                        <h2>15 October 2025</h2>
                    </div>
                </div>
                <!-- End Creator Information -->

            </div>
        </main>
        <!-- End Main -->
    </div>
</body>

</html>