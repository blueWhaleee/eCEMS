<%-- 
    Document   : elections
    Created on : Dec 26, 2025, 8:00:18 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Home" />

    <sql:query dataSource="${myDatasource}" var="stats">
        SELECT 
            COUNT(*) FILTER (WHERE status = 'upcoming') as upcoming_count,
            COUNT(*) FILTER (WHERE status = 'active') as active_count,
            COUNT(*) FILTER (WHERE status = 'closed') as closed_count
        FROM public.elections
        WHERE (campus_id IS NULL OR campus_id = ?) 
        AND (faculty_id IS NULL OR faculty_id = ?)
        <sql:param value="${loggedUser.campus_id}" />
        <sql:param value="${loggedUser.faculty_id}" />
    </sql:query>
    <c:set var="counts" value="${stats.rows[0]}" />

    <sql:query dataSource="${myDatasource}" var="electionList">
        SELECT DISTINCT ON (e.election_id)
            e.*,
            CASE 
                WHEN v.student_id IS NOT NULL THEN 'voted'
                ELSE 'not-voted'
            END as vote_status,
            e.START_DATE::DATE - CURRENT_DATE AS STARTING_IN,
            e.END_DATE::DATE - CURRENT_DATE AS ENDING_IN,
            CURRENT_DATE - e.START_DATE::DATE AS STARTED_AGO,
            CURRENT_DATE - e.END_DATE::DATE AS ENDED_AGO,
            CURRENT_DATE - e.CREATED_AT::DATE AS CREATED_AGO
        FROM public.elections e
        LEFT JOIN public.candidates c ON e.election_id = c.election_id
        LEFT JOIN public.votes v ON c.candidate_id = v.candidate_id AND v.student_id = ?
        WHERE (e.campus_id IS NULL OR e.campus_id = ?)
        AND (e.faculty_id IS NULL OR e.faculty_id = ?)
        ORDER BY e.election_id, e.created_at DESC
        <sql:param value="${loggedUser.stud_id}" />
        <sql:param value="${loggedUser.campus_id}" />
        <sql:param value="${loggedUser.faculty_id}" />
    </sql:query>


    
    <body>
        <div class="d-flex vh-100 overflow-hidden">

            <div class="h-100">
                <%@ include file="/WEB-INF/jspf/nav.jspf" %>
            </div>

            <main class="d-flex flex-grow-1 overflow-hidden">
                
                <div class="flex-grow-1 rounded-start-5 p-4 p-xl-5 overflow-auto no-scrollbar d-flex flex-column gap-4" style="background-color: #F3F9FE;">
                    <h1 class="h4 fw-bold mb-0">Elections</h1>

                    <%-- Statistics START --%>
                    <div class="row g-3">
                        <!-- Upcoming Elections -->
                        <div class="col-12 col-md-3">
                            <div class="card border-0 shadow-sm h-100" style="background: linear-gradient(135deg, #1e1b4b 0%, #2d2a5a 100%); border-radius: 1rem;">
                                <div class="card-body px-3 py-2">
                                    <div class="d-flex align-items-center justify-content-center gap-3 h-100 px-4">
                                        <div class="me-auto">
                                            <h3 class="h6 text-white fw-semibold mb-0">Upcoming</h3>
                                            <p class="small text-white opacity-75 mb-0">Elections</p>
                                        </div>
                                        <div class="display-4 fw-bold text-white">16</div>
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
                                        <div class="display-4 fw-bold text-white">3</div>
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
                                        <div class="display-4 fw-bold" style="color: #1e1b4b;">10</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- Statistics END --%>

                    <!-- Search and Filter Section -->
                    <div class="row g-3 align-items-center">
                    
                        <!-- Search Input -->
                        <div class="col-12">
                            <div class="input-group w-100 position-relative">
                                <svg class="position-absolute z-3 text-secondary" style="left: 1rem; bottom: 15%; " width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <circle cx="10" cy="10" r="7" stroke="currentColor" stroke-opacity="0.9" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                    <path d="M21 21L15 15" stroke="currentColor" stroke-opacity="0.9" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                </svg>
                                <input type="text" name="search" value="${param.search}" class="form-control col-11 px-5 bg-white rounded-pill z-2" placeholder="Search Election">
                            </div>
                        </div>

                        <!-- Filter Buttons -->
                        <div class="col-12 mb-0 mt-2">
                            <div class="d-flex flex-wrap gap-2">
                                <button type="button" class="filter-btn btn rounded-pill px-4 btn-primary" data-filter="all">
                                    All
                                </button>
                                <button type="button" class="filter-btn btn rounded-pill px-4 bg-white border border-1" data-filter="voted">
                                    Voted
                                </button>
                                <button type="button" class="filter-btn btn rounded-pill px-4 bg-white border border-1" data-filter="active">
                                    Active
                                </button>
                                <button type="button" class="filter-btn btn rounded-pill px-4 bg-white border border-1" data-filter="upcoming">
                                    Upcoming
                                </button>
                                <button type="button" class="filter-btn btn rounded-pill px-4 bg-white border border-1" data-filter="closed">
                                    Closed
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="row g-3" id="electionContainer">
                        <!-- No Results Message -->
                        <div class="col-12" id="noResultsMessage" style="display: none;">
                            <div class="border-0">
                                <div class="p-5 text-center">
                                    <svg width="64" height="64" fill="#3d367f" viewBox="0 0 16 16" class="mb-3">
                                        <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                        <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                                    </svg>
                                    <h3 class="h5 text-dark mb-0">No Elections Found</h3>
                                    <p class="text-dark opacity-75 mb-0">Try adjusting your search or filter to find elections.</p>
                                </div>
                            </div>
                        </div>
                        <c:if test="${empty electionList}">
                            <div class="col-12">
                                <div class="border-0">
                                    <div class="p-5 text-center">
                                        <svg width="64" height="64" fill="#3d367f" viewBox="0 0 16 16" class="mb-3">
                                            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                            <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                                        </svg>
                                        <h3 class="h5 text-dark mb-0">No Elections Found</h3>
                                        <p class="text-dark opacity-75 mb-0">Try adjusting your search or filter to find elections.</p>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <c:forEach var="election" items="${electionList.rows}">
                            <div 
                                class="election-item col-12 col-lg-6 col-xl-4"
                                data-title="${fn:toLowerCase(election.title)}" 
                                data-status="${election.status}"
                                data-voted="${election.vote_status}"
                            >
                                <div class="card border-0 shadow-sm h-100 card-anim" style="background-color: #FFF; border-radius: 1rem; cursor: pointer; transition: transform 0.2s;"
                                    onclick="location.href='${pageContext.request.contextPath}/elections/${election.election_id}'">
                                    <div class="card-body p-4 d-flex flex-column justify-content-between">
                                        <!-- Status Badge -->
                                        <c:choose>
                                            <c:when test="${election.status == 'upcoming'}">
                                                <span class="badge rounded-2 px-3 py-2 mb-3" style="background-color: #4c3d99; color: white; font-size: 0.75rem; font-weight: 600; width: fit-content; ">
                                                    Upcoming
                                                </span>
                                            </c:when>
                                            <c:when test="${election.status == 'active'}">
                                                <span class="badge rounded-2 px-3 py-2 mb-3" style="background-color: #7367F0; color: white; font-size: 0.75rem; font-weight: 600; width: fit-content; ">
                                                    Active
                                                </span>
                                            </c:when>
                                            <c:when test="${election.status == 'closed'}">
                                                <span class="badge rounded-2 px-3 py-2 mb-3" style="background-color: #d4d4f7; color: #5b4fc9; font-size: 0.75rem; font-weight: 600; width: fit-content; ">
                                                    Closed
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge rounded-2 px-3 py-2 mb-3" style="background-color: #9CA3AF; color: white; font-size: 0.75rem; font-weight: 600; width: fit-content; ">
                                                    ${election.status}
                                                </span>
                                            </c:otherwise>
                                        </c:choose>

                                        <!-- Election Title -->
                                        <h3 class="h6 fw-bold mb-3" style="color: #1e1b4b; line-height: 1.4;">
                                            ${election.title}
                                        </h3>

                                        <!-- Election Details -->
                                        <div class="d-flex gap-2">
                                            <c:choose>
                                                <c:when test="${election.status == 'upcoming'}">
                                                    <span class="badge rounded-pill bg-white px-3 py-2 align-self-start fw-normal text-black border border-1 border-secondary">
                                                        Starting in ${election.STARTING_IN} days
                                                    </span>
                                                    <c:if test="${election.candidacy_open}">
                                                        <span class="badge rounded-pill bg-primary-subtle px-3 py-2 align-self-start fw-normal text-black border border-1 border-dark">
                                                            Candidate Registration
                                                        </span>
                                                    </c:if>
                                                </c:when>
                                                <c:when test="${election.status == 'active'}">
                                                    <span class="badge rounded-pill bg-white px-3 py-2 align-self-start fw-normal text-black border border-1 border-secondary">
                                                        Started ${election.STARTING_AGO} days ago
                                                    </span>
                                                    <span class="badge rounded-pill bg-white px-3 py-2 align-self-start fw-normal text-black border border-1 border-secondary">
                                                        Ending in ${election.ENDING_IN} days
                                                    </span>
                                                    <p class="small text-secondary mb-0">
                                                        <svg width="14" height="14" fill="currentColor" viewBox="0 0 16 16" class="me-1">
                                                            <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71V3.5z"/>
                                                        </svg>
                                                        Ending <fmt:formatDate value="${election.end_date}" pattern="MMM dd, yyyy"/>
                                                    </p>
                                                </c:when>
                                                <c:when test="${election.status == 'closed'}">
                                                    <span class="badge rounded-pill bg-white px-3 py-2 align-self-start fw-normal text-black border border-1 border-secondary">
                                                        Ended ${election.ENDED_AGO} days ago
                                                    </span>
                                                    <span class="badge rounded-pill bg-primary-subtle px-3 py-2 align-self-start fw-normal text-black border border-1 border-dark">
                                                        View Results
                                                    </span>
                                                </c:when>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    

                </div>
            </main>
        </div>

        <%-- Javascripts  --%>
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>
        <script>
            $(document).ready(function() {
                $('input[name="search"]').on('keyup', function() {
                    filterElections();
                });

                $('.filter-btn').on('click', function() {
                    $('.filter-btn').removeClass('btn-primary').addClass('bg-white border border-1');
                    $(this).addClass('btn-primary').removeClass('bg-white border border-1');
                    
                    filterElections();
                });

                function filterElections() {
                    var searchTerm = $('input[name="search"]').val().toLowerCase();
                    var activeFilter = $('.filter-btn.btn-primary').data('filter');
                    var visibleCount = 0;

                    $('.election-item').each(function() {
                        var title = $(this).data('title') || "";
                        var status = $(this).data('status');
                        var voted = $(this).data('voted');
                        
                        var matchesSearch = title.includes(searchTerm);
                        var matchesFilter = false;

                        if (activeFilter === 'all') {
                            matchesFilter = true;
                        } else if (activeFilter === 'voted') {
                            matchesFilter = (voted === 'voted');
                        } else {
                            matchesFilter = (status === activeFilter);
                        }

                        if (matchesSearch && matchesFilter) {
                            $(this).show();
                            visibleCount++;
                        } else {
                            $(this).hide();
                        }
                    });

                    // Toggle "No Results" message
                    if (visibleCount === 0) {
                        $('#noResultsMessage').show();
                    } else {
                        $('#noResultsMessage').hide();
                    }
                }
            });
        </script>
    </body>
</html>

