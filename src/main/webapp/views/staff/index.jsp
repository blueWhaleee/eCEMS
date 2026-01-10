<%-- 
    Document   : index
    Created on : Dec 25, 2025, 9:56:32 PM
    Author     : ASUS
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Home" />
    
    <body style="background-color: #121026">
        <div class="d-flex vh-100 overflow-hidden">

            <div class="h-100">
                <%@ include file="/WEB-INF/jspf/nav_staff.jspf" %>
            </div>

            <main class="d-flex flex-grow-1 overflow-hidden">
                
                <div class="flex-grow-1 rounded-start-5 p-4 p-xl-5 overflow-auto no-scrollbar d-flex flex-column gap-4" style="background-color: #F3F9FE;">
                    <h1 class="h4 fw-bold mb-0">Home</h1>

                    <div class="rounded-4 px-5 py-4 text-white position-relative shadow-sm" style="background: linear-gradient(90deg, #121026 0%, #7065E9 100%);">
                        <div class="position-relative" style="z-index: 2;">
                            <h2 class="display-6 fw-bold mb-0">Welcome Back,</h2>
                            <p class="fs-4 text-white fw-lighter mb-0">${sessionScope.loggedUser.full_name}</p>
                        </div>
                        <img src="${pageContext.request.contextPath}/assets/image/home_logo.svg" alt="Home Logo" class="position-absolute d-none d-md-block" style="width: 14rem; right: 5%; top: -20px;">
                    </div>

                    <div class="row g-3">
                        <!-- Upcoming Elections -->
                        <div class="col-12 col-md-4">
                            <div class="card border-0 shadow-sm h-100" style="background: linear-gradient(135deg, #1e1b4b 0%, #2d2a5a 100%); border-radius: 1rem;">
                                <div class="card-body px-3 py-2">
                                    <div class="d-flex align-items-center justify-content-center gap-3 h-100 px-4">
                                        <div class="me-auto">
                                            <h3 class="h6 text-white fw-semibold mb-0">Students</h3>
                                            <p class="small text-white opacity-75 mb-0">registered</p>
                                        </div>
                                        <div class="display-4 fw-bold text-white">${counts.upcoming_count != null ? counts.upcoming_count : 0}</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Active Elections -->
                        <div class="col-12 col-md-4">
                            <div class="card border-0 shadow-sm h-100" style="background: linear-gradient(135deg, #4c3d99 0%, #5b4fc9 100%); border-radius: 1rem;">
                                <div class="card-body px-3 py-2">
                                    <div class="d-flex align-items-center justify-content-center gap-3 h-100 px-4">
                                        <div class="me-auto">
                                            <h3 class="h6 text-white fw-semibold mb-0">Staff</h3>
                                            <p class="small text-white opacity-75 mb-0">registered</p>
                                        </div>
                                        <div class="display-4 fw-bold text-white">${counts.active_count != null ? counts.active_count : 0}</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Closed Elections -->
                        <div class="col-12 col-md-4">
                            <div class="card border-0 shadow-sm h-100" style="background-color: #d4d4f7; border-radius: 1rem;">
                                <div class="card-body px-3 py-3">
                                    <div class="d-flex align-items-center justify-content-center gap-3 h-100 px-4">
                                        <div class="me-auto">
                                            <h3 class="h6 fw-semibold mb-0" style="color: #1e1b4b;">Elections</h3>
                                            <p class="small mb-0" style="color: #5b4fc9;">created</p>
                                        </div>
                                        <div class="display-4 fw-bold" style="color: #1e1b4b;">${counts.closed_count != null ? counts.closed_count : 0}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="mt-2">
                        <h3 class="h6 fw-bold text-dark text-uppercase mb-3">Active Elections</h3>

                        <div class="table-responsive mx-3">
                            <table class="table table-borderless table-striped table-rounded mb-0" style="border-collapse: separate; border-spacing: 0 5px;">                                
                                <thead class="text-secondary small fw-bold">
                                    <tr>
                                        <th class="ps-4" style="width: 50%;">ELECTIONS</th>
                                        <th class="">NO. OF CANDIDATES</th>
                                        <th class="text-end pe-4">ENDING DATE</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="py-2 ps-4 text-secondary fw-normal rounded-start-5">Jawatankuasa Perwakilan Pelajar Fakulti Sains Komputer dan Matematik</td>
                                        <td class="py-2 text-secondary">2025148595</td>
                                        <td class="py-2 text-end pe-4 text-secondary rounded-end-5">10, Jan 2020 20:07</td>
                                    </tr>
                                    <tr>
                                        <td class="py-2 ps-4 text-secondary fw-normal rounded-start-5">Jawatankuasa Perwakilan Kolej UiTM Shah Alam</td>
                                        <td class="py-2 text-secondary">2025148599</td>
                                        <td class="py-2 text-end pe-4 text-secondary rounded-end-5">11, Jan 2020 10:16</td>
                                    </tr>
                                    <tr>
                                        <td class="py-2 ps-4 text-secondary fw-normal rounded-start-5">Jawatankuasa Perwakilan Kolej UiTM Shah Alam</td>
                                        <td class="py-2 text-secondary">2025148333</td>
                                        <td class="py-2 text-end pe-4 text-secondary rounded-end-5">11, Jan 2020 10:16</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="h-100 bg-primary-subtle rounded-4 p-4 px-5 d-flex align-items-center justify-content-between mt-auto">
                                <div>
                                    <h3 class="h5 fw-bold text-dark mb-2">View Elections</h3>
                                    <p class="small text-dark opacity-75 mb-0 lh-1">Vote in elections or register as candidate</p>
                                </div>
                                <button class="card-anim btn btn-outline-primary bg-white text-primary rounded-pill px-4 shadow-sm d-flex justify-content-between align-items-center gap-2" onclick="location.href='elections.html'">
                                    Elections
                                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M4.16675 9.99992H15.8334" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                        <path d="M10.8333 15L15.8333 10" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                        <path d="M10.8333 5L15.8333 10" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                    </svg>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="h-100 bg-primary-subtle rounded-4 p-4 px-5 d-flex align-items-center justify-content-between mt-auto">
                                <div>
                                    <h3 class="h5 fw-bold text-dark mb-2">Create Elections</h3>
                                    <p class="small text-dark opacity-75 mb-0 lh-1">Create a new campus-wide or faculty-specific election</p>
                                </div>
                                <button class="card-anim btn btn-outline-primary bg-white text-primary rounded-pill px-4 shadow-sm d-flex justify-content-between align-items-center gap-2" onclick="location.href='elections.html'">
                                    Create
                                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M4.16675 9.99992H15.8334" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                        <path d="M10.8333 15L15.8333 10" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                        <path d="M10.8333 5L15.8333 10" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                    </svg>
                                </button>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="d-none d-xl-block bg-white p-4 p-xl-5" style="width: 300px; min-width: 25%;">
                    <h3 class="h6 fw-bold text-dark text-uppercase">Statistics</h3>
                    <hr class="text-muted">
                    </div>

            </main>
        </div>

        <%-- Javascripts  --%>
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>
    </body>
</html>
