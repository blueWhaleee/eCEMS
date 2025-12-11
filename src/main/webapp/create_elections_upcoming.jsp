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
    <title>eCEMS | Post</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/nav.css" type="text/css">
    <link rel="stylesheet" href="./css/create_elections_create.css" type="text/css">
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
                <li onclick="location.href='create_elections.jsp'" class="menu__button-item menu__button-active">
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
                <li onclick="location.href='reports.jsp'" class="menu__button-item">
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
                <p> <%= usr.getStudentNo() %> </p>
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
                <h1>Post (Upcoming)</h1>

                <!-- Return Button -->
                <button class="main__container__return" onclick="location.href='./create_elections.jsp'">
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

                <!-- If Status = Upcoming -->
                <!-- Candidate Form -->
                <form class="main__container__form">
                    <div class="main__container__form-title">
                        <h3>Create Election</h3>
                        <p>Fill in the details below to create student election</p>
                    </div>

                    <div class="main__container__form-input">
                        <label for="">Election Title</label>
                        <input type="text" value="">
                    </div>
                    <div class="main__container__form-input">
                        <label for="">Election Description</label>
                        <textarea rows="8" style="height: 6rem;" value="\n\n\n"></textarea>
                    </div>

                    <div class="main__container__form-multi">
                        <div class="main__container__form-input">
                            <label for="">Election Session</label>
                            <input type="text" value="">
                        </div>
                        <div class="main__container__form-input">
                            <label for="">Election Type</label>
                            <input type="text" value="">
                        </div>
                    </div>

                    <button class="main__container__return" style="background-color: #121026; color: #FFFFFF;" type="submit">
                        Create Election
                    </button>
                </form>
                <!-- End Candidate Form -->

                <!-- Candidate Registration  -->
                <div class="main__container__form">
                    <div class="main__container__form-title">
                        <h3>Candidates Registration</h3>
                        <p>List of students registered to be candidates</p>
                    </div>
                     <table class="main__container__table">
                        <thead>
                            <tr>
                                <th>CANDIDATE NAME</th>
                                <th>CANDIDATE PROFILE</th>
                                <th>ACTIONS</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><div>AMER SYAFIQ BIN ABDUL RAZAK</div></td>
                                <td><div><a href="#">View Profile</a></div></td>
                                <td><div style="color: red;"><a href="#">Reject Candidate</a></div></td>
                            </tr>
                            <tr>
                                <td><div>AMER SYAFIQ BIN ABDUL RAZAK</div></td>
                                <td><div><a href="#">View Profile</a></div></td>
                                <td><div style="color: red;"><a href="#">Reject Candidate</a></div></td>
                            </tr>
                            <tr>
                                <td><div>AMER SYAFIQ BIN ABDUL RAZAK</div></td>
                                <td><div><a href="#">View Profile</a></div></td>
                                <td><div style="color: red;"><a href="#">Reject Candidate</a></div></td>
                            </tr>
                            <tr>
                                <td><div>AMER SYAFIQ BIN ABDUL RAZAK</div></td>
                                <td><div><a href="#">View Profile</a></div></td>
                                <td><div style="color: red;"><a href="#">Reject Candidate</a></div></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>


            <div class="main__side">
                <h3>Information</h3>

                <!-- Creator Information -->
                <div class="main__side__profile">
                    <div class="main__side__profile-user">
                        <p>Created By</p>
                        <div>
                            <div class="main__side__profile-user-img">
                                <img src="./image/profile_img.png" alt="">
                            </div>
                            <div class="main__side__profile-user-desc">
                                <h4> <%= usr.getFullName() %> </h4>
                                <p> <%= usr.getRole() %> </p>
                            </div>
                        </div>
                    </div>
                    <div class="main__side__profile-date_wrapper">
                        <div class="main__side__profile-date">
                            <p>Created On</p>
                            <h2>15 October 2025</h2>
                        </div>
                        <div class="main__side__profile-date">
                            <p>Started On</p>
                            <h2>16 October 2025</h2>
                        </div>
                        <div class="main__side__profile-date">
                            <p>Ending On</p>
                            <h2>17 October 2025</h2>
                        </div>
                    </div>
                </div>
                <!-- End Creator Information -->

                <button class="main__side__data" style="background-color: #7367F0;">
                    <div style="align-items: center;">
                        <svg width="60" height="60" viewBox="0 0 60 60" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M10 32.5C19.1755 33.5904 26.4096 40.8245 27.5 50C31.9927 47.4099 34.8288 42.683 35 37.5C43.5844 34.4801 49.5046 26.5866 50 17.5C50 13.3579 46.6421 10 42.5 10C33.4134 10.4954 25.5199 16.4156 22.5 25C17.317 25.1712 12.5901 28.0073 10 32.5" stroke="white" stroke-opacity="0.9" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M17.5002 35C12.1775 38.0049 9.21054 43.9389 10.0002 50C16.0613 50.7896 21.9953 47.8226 25.0002 42.5" stroke="white" stroke-opacity="0.9" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                            <circle cx="37.5" cy="22.5" r="2.5" stroke="white" stroke-opacity="0.9" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>

                        <h3>Start Election</h3>
                        <p>Confirm Election Information</p>
                    </div>
                </button>
                <button class="main__side__data">
                    <div style="align-items: center;">
                        <svg width="60" height="60" viewBox="0 0 60 60" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <circle cx="30" cy="30" r="22.5" stroke="white" stroke-opacity="0.9" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M26.0607 23.9393C25.4749 23.3536 24.5251 23.3536 23.9393 23.9393C23.3536 24.5251 23.3536 25.4749 23.9393 26.0607L25 25L26.0607 23.9393ZM33.9393 36.0607C34.5251 36.6464 35.4749 36.6464 36.0607 36.0607C36.6464 35.4749 36.6464 34.5251 36.0607 33.9393L35 35L33.9393 36.0607ZM36.0607 26.0607C36.6464 25.4749 36.6464 24.5251 36.0607 23.9393C35.4749 23.3536 34.5251 23.3536 33.9393 23.9393L35 25L36.0607 26.0607ZM23.9393 33.9393C23.3536 34.5251 23.3536 35.4749 23.9393 36.0607C24.5251 36.6464 25.4749 36.6464 26.0607 36.0607L25 35L23.9393 33.9393ZM25 25L23.9393 26.0607L33.9393 36.0607L35 35L36.0607 33.9393L26.0607 23.9393L25 25ZM35 25L33.9393 23.9393L23.9393 33.9393L25 35L26.0607 36.0607L36.0607 26.0607L35 25Z" fill="white" fill-opacity="0.9"/>
                        </svg>


                        <h3>Cancel Election</h3>
                        <p>This action is irreversible</p>
                    </div>
                </button>
            </div>
        </main>
        <!-- End Main -->
    </div>
</body>

</html>