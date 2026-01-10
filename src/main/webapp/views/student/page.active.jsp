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
                <%@ include file="/WEB-INF/jspf/nav_stud.jspf" %>
            </div>

            <main class="d-flex flex-grow-1 overflow-hidden">
                
                <div class="flex-grow-1 rounded-start-5 p-4 p-xl-5 overflow-auto no-scrollbar d-flex flex-column gap-4" style="background-color: #F3F9FE;">
                    <h1 class="h4 fw-bold mb-0">Active Election</h1>


                </div>

                <div class="d-none d-xl-block bg-white p-4 p-xl-5" style="width: 300px; min-width: 25%;">
                    <h3 class="h6 fw-bold text-dark text-uppercase">Informations</h3>
                    <hr class="text-muted">
                    </div>

            </main>
        </div>

        <%-- Javascripts  --%>
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>
    </body>
</html>
