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
        <main class="container-fluid p-0 vh-100 overflow-hidden position-relative">
            <div class="row g-0 h-100">
                
                <div class="col-lg-4 col-xl-4 bg-white p-4 p-md-5 d-flex flex-column justify-content-center overflow-y-auto h-100">
                    
                    <img class="mb-4 mx-auto d-block" src="${pageContext.request.contextPath}/assets/image/uitm_logo.png" 
                        alt="UiTM Logo" style="width: 8rem;">
                    
                    <div class="w-100 mb-3">
                        <h1 class="h4 fw-bold">Welcome to UiTM eCEMS 👋🏻</h1>
                        <p class="text-secondary small">Sign up account for new user</p>
                    </div>

                    <form action="${pageContext.request.contextPath}/register" method="POST">
                        
                        <div class="mb-2">
                            <sql:query var="campusList" dataSource="${myDatasource}">
                                SELECT * FROM CAMPUS
                            </sql:query>
                            <label for="campus_id" class="form-label small fw-semibold mb-1">Campus</label>
                            <select name="campus_id" class="form-select form-select-sm" 
                                    onChange="javascript:location.href='${pageContext.request.contextPath}/register?campus=' + this.value">
                                <option value="-1" <c:if test="${param.campus == '-1' || param.campus == null}">selected</c:if>>Select Campus</option>
                                <c:forEach var="campus" items="${campusList.rows}">
                                    <option value="${campus.campus_id}" <c:if test="${param.campus == campus.campus_id}">selected</c:if>>${campus.campus_name}</option> 
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-2">
                            <sql:query var="facultyList" dataSource="${myDatasource}">
                                SELECT * FROM FACULTY WHERE CAMPUS_ID = ?::integer
                                <sql:param value="${param.campus}"/>
                            </sql:query>
                            <label for="faculty_id" class="form-label small fw-semibold mb-1">Faculty</label>
                            <select name="faculty_id" class="form-select form-select-sm" <c:if test="${empty param.campus}">disabled</c:if>>
                                <option value="-1" <c:if test="${param.campus == '-1' || param.campus == null}">selected</c:if>>Select Faculty</option>
                                <c:forEach var="faculty" items="${facultyList.rows}">
                                    <option value="${faculty.faculty_id}">${faculty.faculty_name}</option> 
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-2">
                            <label for="email" class="form-label small fw-semibold mb-1">Email</label>
                            <input name="email" type="email" class="form-control form-control-sm" placeholder="Enter your email" required>
                        </div>

                        <div class="mb-2">
                            <label for="full_name" class="form-label small fw-semibold mb-1">Full Name</label>
                            <input name="full_name" type="text" class="form-control form-control-sm" placeholder="Enter your name" required>
                        </div>

                        <div class="mb-2">
                            <label for="stud_number" class="form-label small fw-semibold mb-1">Student Number</label>
                            <input name="stud_number" type="text" class="form-control form-control-sm" placeholder="Enter your Student Number" required>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label small fw-semibold mb-1">Password</label>
                            <input name="password" type="password" class="form-control form-control-sm" placeholder="············" required>
                        </div>

                        <button class="btn btn-primary w-100 py-2 shadow-sm mb-3" type="submit">Sign Up</button>
                    </form>

                    <p class="small text-secondary text-center">
                        Already have an account?
                        <a href="${pageContext.request.contextPath}/login" class="text-decoration-none fw-semibold">Sign in instead</a>
                    </p>
                </div>

                <div class="col-lg-8 col-xl-8 d-none d-lg-flex bg-primary-subtle justify-content-center align-items-center p-5">
                    <img src="${pageContext.request.contextPath}/assets/image/banner.png" 
                        alt="Banner" class="img-fluid" style="max-height: 80vh;">
                </div>

            </div>

            <c:if test="${not empty errors}">
                <div class="position-absolute bottom-0 end-0 p-3" style="z-index: 1050; max-width: 400px;">
                    <c:forEach var="err" items="${errors}">
                        <div class="alert alert-danger alert-dismissible fade show shadow-sm d-flex align-items-center mb-2" role="alert">
                            <div class="small">${err}</div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

        </main>
    </body>
</html>
