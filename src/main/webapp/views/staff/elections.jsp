<%-- 
    Document   : elections
    Created on : Dec 26, 2025, 8:00:18 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Elections" />

    <sql:query dataSource="${myDatasource}" var="stats">
        SELECT 
            COUNT(*) AS ALL_COUNT,
            COUNT(*) FILTER (WHERE STATUS = 'upcoming') AS UPCOMING_COUNT,
            COUNT(*) FILTER (WHERE STATUS = 'active') AS ACTIVE_COUNT,
            COUNT(*) FILTER (WHERE STATUS = 'closed') AS CLOSED_COUNT
        FROM ELECTIONS
        WHERE (CAMPUS_ID IS NULL OR CAMPUS_ID = ?)
        <sql:param value="${loggedUser.campus_id}" />
    </sql:query>
    <c:set var="counts" value="${stats.rows[0]}" />

    <sql:query dataSource="${myDatasource}" var="electionList">
        SELECT 
            ELECTION_ID,
            TITLE,
            STATUS,
            STAFF_NUMBER,
            FULL_NAME,
            PROFILE_PATH,
            CREATED_AT
        FROM ELECTIONS E
        LEFT JOIN STAFFS S ON E.CREATED_BY = S.STAFF_ID
        WHERE (e.campus_id IS NULL OR e.campus_id = ?)
        <sql:param value="${loggedUser.campus_id}" />
    </sql:query>
    
    <body style="background-color: #121026">
        <div class="d-flex vh-100 overflow-hidden">

            <div class="h-100">
                <%@ include file="/WEB-INF/jspf/nav_staff.jspf" %>
            </div>

            <main class="d-flex flex-grow-1 overflow-hidden">
                
                <div class="flex-grow-1 rounded-start-5 rounded-start-5 p-4 p-xl-5 overflow-auto no-scrollbar d-flex flex-column gap-4" style="background-color: #F3F9FE;">
                    <h1 class="h4 fw-bold mb-0">Elections</h1>

                    <%-- Statistics START --%>
                    <div class="row g-3">
                        <!-- All Elections -->
                        <div class="col-12 col-md-3">
                            <div class="card border-0 shadow-sm h-100 bg-white border border-1" style="border-radius: 1rem;">
                                <div class="card-body px-3 py-2">
                                    <div class="d-flex align-items-center justify-content-center gap-3 h-100 px-4">
                                        <div class="me-auto">
                                            <h3 class="h6 text-dark fw-semibold mb-0">All</h3>
                                            <p class="small text-dark opacity-75 mb-0">Elections</p>
                                        </div>
                                        <div class="display-4 fw-bold text-dark">${counts.all_count != null ? counts.all_count : 0}</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Upcoming Elections -->
                        <div class="col-12 col-md-3">
                            <div class="card border-0 shadow-sm h-100" style="background: linear-gradient(135deg, #1e1b4b 0%, #2d2a5a 100%); border-radius: 1rem;">
                                <div class="card-body px-3 py-2">
                                    <div class="d-flex align-items-center justify-content-center gap-3 h-100 px-4">
                                        <div class="me-auto">
                                            <h3 class="h6 text-white fw-semibold mb-0">Upcoming</h3>
                                            <p class="small text-white opacity-75 mb-0">Elections</p>
                                        </div>
                                        <div class="display-4 fw-bold text-white">${counts.UPCOMING_COUNT != null ? counts.UPCOMING_COUNT : 0}</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Active Elections -->
                        <div class="col-12 col-md-3">
                            <div class="card border-0 shadow-sm h-100" style="background: linear-gradient(135deg, #4c3d99 0%, #5b4fc9 100%); border-radius: 1rem;">
                                <div class="card-body px-3 py-2">
                                    <div class="d-flex align-items-center justify-content-center gap-3 h-100 px-4">
                                        <div class="me-auto">
                                            <h3 class="h6 text-white fw-semibold mb-0">Active</h3>
                                            <p class="small text-white opacity-75 mb-0">Elections</p>
                                        </div>
                                        <div class="display-4 fw-bold text-white">${counts.ACTIVE_COUNT != null ? counts.ACTIVE_COUNT : 0}</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Closed Elections -->
                        <div class="col-12 col-md-3">
                            <div class="card border-0 shadow-sm h-100" style="background-color: #d4d4f7; border-radius: 1rem;">
                                <div class="card-body px-3 py-3">
                                    <div class="d-flex align-items-center justify-content-center gap-3 h-100 px-4">
                                        <div class="me-auto">
                                            <h3 class="h6 fw-semibold mb-0" style="color: #1e1b4b;">Closed</h3>
                                            <p class="small mb-0" style="color: #5b4fc9;">Elections</p>
                                        </div>
                                        <div class="display-4 fw-bold" style="color: #1e1b4b;">${counts.CLOSED_COUNT != null ? counts.CLOSED_COUNT : 0}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- Statistics END --%>

                    <!-- Datatable -->
                    <div class="datatable-container">
                        <div class="header-bar">
                            <div class="show-entries">
                                <label for="page-length">Show</label>
                                <select id="page-length" class="form-select ms-2 pe-4">
                                    <option value="10" selected>10</option>
                                    <option value="25">25</option>
                                    <option value="50">50</option>
                                    <option value="100">100</option>
                                </select>
                            </div>

                            <div style="display: flex; align-items: center; gap: 15px;">
                                <div class="search-box">
                                    <label for="global-search" style="display:none;">Search</label>
                                    <input type="text" id="global-search" class="form-control" placeholder="Search Election">
                                </div>
                                <button onclick="location.href='${pageContext.request.contextPath}/elections/create'" class="btn btn-primary px-3">Create Election</button>
                            </div>
                        </div>

                        <!-- Table -->
                        <table id="electionTable" class="display" style="width:100%">
                            <thead>
                                <tr>
                                    <th>ELECTION TITLE</th>
                                    <th>STATUS</th>
                                    <th>CREATED BY</th>
                                    <th>CREATION DATE</th>
                                    <th>ACTION</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="election" items="${electionList.rows}">
                                    <tr>
                                        <td>${election.title}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${election.status == 'upcoming'}">
                                                    <span class="badge rounded-2 px-3 py-2" style="background-color: #4c3d99; color: white; font-size: 0.75rem; font-weight: 600; width: fit-content; ">
                                                        Upcoming
                                                    </span>
                                                </c:when>
                                                <c:when test="${election.status == 'active'}">
                                                    <span class="badge rounded-2 px-3 py-2" style="background-color: #7367F0; color: white; font-size: 0.75rem; font-weight: 600; width: fit-content; ">
                                                        Active
                                                    </span>
                                                </c:when>
                                                <c:when test="${election.status == 'closed'}">
                                                    <span class="badge rounded-2 px-3 py-2" style="background-color: #d4d4f7; color: #5b4fc9; font-size: 0.75rem; font-weight: 600; width: fit-content; ">
                                                        Closed
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge rounded-2 px-3 py-2" style="background-color: #9CA3AF; color: white; font-size: 0.75rem; font-weight: 600; width: fit-content; ">
                                                        ${election.status}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>  
                                        </td>
                                        <td><img src="${election.profile_path}" onerror="this.onerror=null; this.src='https://placehold.co/600x400?text=No+Image';" alt="Staff Profile" class="avatar">${election.full_name}</td>
                                        <td><fmt:formatDate value="${election.created_at}" pattern="dd MMM yyyy, h:mm a"/></td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/elections/page/${election.election_id}" class="action-link d-flex align-items-center gap-2">
                                                <c:choose>
                                                    <c:when test="${election.status == 'closed' || election.status == 'cancelled' || election.status == 'active'}">
                                                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <circle cx="9.99992" cy="10.0002" r="1.66667" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                                            <path d="M18.3334 9.99984C16.1109 13.889 13.3334 15.8332 10.0001 15.8332C6.66675 15.8332 3.88925 13.889 1.66675 9.99984C3.88925 6.11067 6.66675 4.1665 10.0001 4.1665C13.3334 4.1665 16.1109 6.11067 18.3334 9.99984" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                                        </svg>
                                                        View
                                                    </c:when>
                                                    <c:otherwise>
                                                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M7.49992 5.83325H4.99992C4.07944 5.83325 3.33325 6.57944 3.33325 7.49992V14.9999C3.33325 15.9204 4.07944 16.6666 4.99992 16.6666H12.4999C13.4204 16.6666 14.1666 15.9204 14.1666 14.9999V12.4999" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                                            <path d="M7.5 12.5H10L17.0833 5.41669C17.7737 4.72634 17.7737 3.60705 17.0833 2.91669C16.393 2.22634 15.2737 2.22634 14.5833 2.91669L7.5 10V12.5" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                                            <path d="M13.3333 4.16675L15.8333 6.66675" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                                        </svg>
                                                        Modify
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                <!-- End Datatable -->

                    

                </div>
            </main>
        </div>

        <%-- Javascripts  --%>
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>
        <script>
            $(document).ready(function () {
                const table = $('#electionTable').DataTable({
                    paging: true,
                    pageLength: 10,
                    lengthMenu: [10, 25, 50, 100],
                    searching: true,
                    ordering: true,
                    order: [],
                    info: true,
                    responsive: true,
                    dom: 'rt<"bottom"ip><"clear">',
                    columnDefs: [
                        { orderable: false, targets: 4 }, 
                        { searchable: false, targets: [1, 2, 3] }
                    ],
                    language: {
                        search: "",
                        searchPlaceholder: "Search Election",
                        info: "Showing _START_ to _END_ of _TOTAL_ entries",
                        lengthMenu: "Show _MENU_ entries",
                        paginate: {
                            previous: "«",
                            next: "»"
                        }
                    },
                    initComplete: function () {
                        $('#page-length').val(this.api().page.len());
                    }
                });

                $('#page-length').on('change', function () {
                    table.page.len($(this.val())).draw();
                });

                $('#global-search').on('keyup', function () {
                    table.search(this.value).draw();
                });
            });
        </script>
    </body>
</html>

