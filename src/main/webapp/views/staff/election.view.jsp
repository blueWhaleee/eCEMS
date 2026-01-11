<%-- 
    Document   : election.view
    Created on : Jan 10, 2026
    Author     : ASUS
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Elections" />
    
    <body style="background-color: #121026">
        <div class="d-flex vh-100 overflow-hidden">

            <div class="h-100">
                <%@ include file="/WEB-INF/jspf/nav_staff.jspf" %>
            </div>

            <main class="d-flex flex-grow-1 overflow-hidden">
                
                <div class="flex-grow-1 rounded-start-5 p-4 p-xl-5 overflow-auto no-scrollbar d-flex flex-column gap-4" style="background-color: #F3F9FE;">
                    <h1 class="h4 fw-bold mb-0">View Election</h1>

                    <a href="${pageContext.request.contextPath}/elections" type="button" class="btn rounded-pill px-4 bg-white border border-1 card-anim" style="width: fit-content;">
                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M4.16675 9.99992H15.8334" stroke="#121026" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M4.16675 10L9.16675 15" stroke="#121026" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M4.16675 10L9.16675 5" stroke="#121026" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        Return
                    </a>

                    <form method="POST" id="view_form">
                        <input type="hidden" name="election_id" value="${election.election_id}"/>
                        <div class="accordion" id="electionAccordion">
                            <div class="accordion-item border-1 shadow-sm mb-3 rounded-4 overflow-hidden">
                                <h2 class="accordion-header">
                                    <button class="accordion-button fw-bold bg-white" type="button" data-bs-toggle="collapse" data-bs-target="#collapseInfo">
                                        1. Basic Information & Scope
                                    </button>
                                </h2>
                                <div id="collapseInfo" class="accordion-collapse collapse show" data-bs-parent="#electionAccordion">
                                    <div class="accordion-body bg-white">
                                        <div class="row g-3">
                                            <sql:query var="campus" dataSource="${myDatasource}">
                                                SELECT * FROM CAMPUS WHERE CAMPUS_ID = ?::integer
                                                <sql:param value="${election.campus_id}"/>
                                            </sql:query>
                                            <c:set var="camp" value="${campus.rows[0]}"/>
                                            
                                            <div class="col-md-5">
                                                <label class="mb-1"><small>Campus</small></label>
                                                <input type="text" class="form-control" value="${camp.campus_name}" disabled/>
                                            </div>
                                            
                                            <div class="col-md-7">
                                                <label class="mb-1"><small>Election Type</small></label>
                                                <input type="text" class="form-control" value="<c:if test="${election.election_type == 'campus'}">Campus-wide</c:if><c:if test="${election.election_type == 'faculty'}">Faculty Specific</c:if>" disabled/>
                                                <c:if test="${election.election_type == 'faculty'}">
                                                    <sql:query var="faculty" dataSource="${myDatasource}">
                                                        SELECT * FROM FACULTY WHERE FACULTY_ID = ?::integer
                                                        <sql:param value="${election.faculty_id}"/>
                                                    </sql:query>
                                                    <c:set var="fac" value="${faculty.rows[0]}"/>
                                                    <small class="text-muted d-block mt-2">${fac.faculty_code} - ${fac.faculty_name}</small>
                                                </c:if>
                                            </div>

                                            <div class="col-md-12">
                                                <label class="mb-1"><small>Election Title</small></label>
                                                <input type="text" name="title" class="form-control" value="${election.title}" disabled/>
                                            </div>

                                            <div class="col-12">
                                                <label class="mb-1"><small>Election Description</small></label>
                                                <textarea id="description" name="description" class="form-control" rows="3" disabled style="field-sizing: content;">${election.description}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="accordion-item border-1 shadow-sm mb-3 rounded-4 overflow-hidden">
                                <h2 class="accordion-header">
                                    <button class="accordion-button fw-bold bg-white" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTimeline">
                                        2. Timeline & Voting Rules
                                    </button>
                                </h2>
                                <div id="collapseTimeline" class="accordion-collapse collapse" data-bs-parent="#electionAccordion">
                                    <div class="accordion-body bg-white">
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <label class="mb-1"><small>Session</small></label>
                                                <input type="text" name="session" class="form-control" value="${election.session}" disabled/>
                                            </div>
                                            
                                            <div class="col-md-6">
                                                <label class="mb-1"><small>Max Votes per Voter</small></label>
                                                <input type="number" name="max_votes" class="form-control" value="${election.max_votes}" disabled/>
                                            </div>

                                            <div class="col-md-6">
                                                <label class="mb-1"><small>Start Date & Time</small></label>
                                                <input type="text" class="form-control" value="${election.start_date.toString().replace('T', ' ')}" disabled/>
                                            </div>

                                            <div class="col-md-6">
                                                <label class="mb-1"><small>End Date & Time</small></label>
                                                <input type="text" class="form-control" value="${election.end_date.toString().replace('T', ' ')}" disabled/>
                                            </div>

                                            <div class="col-12 mt-4">
                                                <div class="card bg-light border-1">
                                                    <div class="card-body py-2 px-3">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="checkbox" id="openCandidacy" disabled 
                                                                <c:if test="${election.candidacy_open}">checked</c:if>>
                                                            <label class="form-check-label fw-semibold" for="openCandidacy">
                                                                Open Candidacy Enabled
                                                            </label>
                                                            <br><small class="text-muted">Students can nominate themselves as candidates.</small>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="accordion-item border-1 shadow-sm mb-3 rounded-4 overflow-hidden">
                                <h2 class="accordion-header">
                                    <button class="accordion-button fw-bold bg-white" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCandidates">
                                        3. Candidate Registration
                                    </button>
                                </h2>
                                <div id="collapseCandidates" class="accordion-collapse collapse" data-bs-parent="#electionAccordion">
                                    <div class="accordion-body bg-white px-0">
                                        <sql:query var="candidates" dataSource="${myDatasource}">
                                            SELECT C.CANDIDATE_ID, C.STUDENT_ID, C.STATUS, C.SLOGAN, C.MANIFESTO, C.PHOTO_URL, C.BANNER_URL, S.FULL_NAME, S.STUD_NUMBER
                                            FROM CANDIDATES C
                                            JOIN STUDENTS S ON C.STUDENT_ID = S.STUD_ID
                                            WHERE C.ELECTION_ID = ?::BIGINT
                                            ORDER BY C.CREATED_AT DESC
                                            <sql:param value="${election.election_id}"/>
                                        </sql:query>

                                        <c:choose>
                                            <c:when test="${empty candidates.rows}">
                                                <div class="text-center text-muted py-4">
                                                    <p class="mb-0">No candidates registered for this election.</p>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="table-responsive">
                                                    <table class="table table-hover mb-0">
                                                        <thead class="table-primary">
                                                            <tr>
                                                                <th class="ps-4" scope="col" style="width: 5%;">#</th>
                                                                <th scope="col" style="width: 40%;">Student Name</th>
                                                                <th scope="col" style="width: 20%;">Student Number</th>
                                                                <th scope="col" style="width: 15%;">Status</th>
                                                                <th class="pe-4" scope="col" style="width: 20%;">Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="candidate" items="${candidates.rows}" varStatus="loop">
                                                                <tr>
                                                                    <td class="ps-4 text-dark">${loop.count}</td>
                                                                    <td class="text-dark">${candidate.full_name}</td>
                                                                    <td class="text-dark">${candidate.stud_number}</td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${candidate.status == 'approved'}">
                                                                                <span class="px-3 py-1 badge bg-primary">Approved</span>
                                                                            </c:when>
                                                                            <c:when test="${candidate.status == 'pending'}">
                                                                                <span class="px-3 py-1 badge bg-primary-subtle text-dark">Pending</span>
                                                                            </c:when>
                                                                            <c:when test="${candidate.status == 'rejected'}">
                                                                                <span class="px-3 py-1 badge bg-danger">Rejected</span>
                                                                            </c:when>
                                                                            <c:when test="${candidate.status == 'withdrawn'}">
                                                                                <span class="px-3 py-1 badge bg-dark text-white">Withdrawn</span>
                                                                            </c:when>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td class="pe-4">
                                                                        <button type="button" class="btn btn-sm btn-outline-primary rounded-pill px-3" 
                                                                            data-bs-toggle="modal" data-bs-target="#candidateModal"
                                                                            onclick="loadCandidateProfile(`${candidate.candidate_id}`, `${candidate.full_name}`, `${candidate.stud_number}`, `${candidate.status}`, `${candidate.slogan}`, `${candidate.manifesto}`, `${candidate.photo_url}`, `${candidate.banner_url}`)">
                                                                            View Profile
                                                                        </button>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                            <c:if test="${election.status == 'active'}">
                                <div class="accordion-item border-1 shadow-sm mb-3 rounded-4 overflow-hidden">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button fw-bold bg-white" type="button" data-bs-toggle="collapse" data-bs-target="#collapseResults">
                                            4. Approved Candidates & Votes
                                        </button>
                                    </h2>
                                    <div id="collapseResults" class="accordion-collapse collapse" data-bs-parent="#electionAccordion">
                                        <div class="accordion-body bg-white px-0">
                                            <sql:query var="approvedCandidates" dataSource="${myDatasource}">
                                                SELECT c.candidate_id, c.student_id, c.elected_position, s.full_name, s.stud_number, COUNT(v.student_id) as total_votes
                                                FROM CANDIDATES c
                                                JOIN STUDENTS s ON c.student_id = s.stud_id
                                                LEFT JOIN VOTES v ON c.candidate_id = v.candidate_id
                                                WHERE c.election_id = ?::bigint AND c.status = 'approved'
                                                GROUP BY c.candidate_id, c.student_id, c.elected_position, s.full_name, s.stud_number
                                                ORDER BY total_votes DESC
                                                <sql:param value="${election.election_id}"/>
                                            </sql:query>

                                            <c:choose>
                                                <c:when test="${empty approvedCandidates.rows}">
                                                    <div class="text-center text-muted py-4">
                                                        <p class="mb-0">There are no approved candidates yet for this election.</p>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="table-responsive">
                                                        <table class="table table-hover mb-0">
                                                            <thead class="table-primary">
                                                                <tr>
                                                                    <th class="ps-4" scope="col" style="width: 5%;">#</th>
                                                                    <th scope="col" style="width: 35%;">Student Name</th>
                                                                    <th scope="col" style="width: 20%;">Student Number</th>
                                                                    <th scope="col" style="width: 20%;">Position</th>
                                                                    <th scope="col" style="width: 12%;">Total Votes</th>
                                                                    <th class="pe-4" scope="col" style="width: 8%;"></th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach var="candidate" items="${approvedCandidates.rows}" varStatus="loop">
                                                                    <tr>
                                                                        <td class="ps-4 text-dark">${loop.count}</td>
                                                                        <td class="text-dark">${candidate.full_name}</td>
                                                                        <td class="text-dark">${candidate.stud_number}</td>
                                                                        <td class="text-dark">${candidate.elected_position}</td>
                                                                        <td>
                                                                            <span class="badge bg-primary">${candidate.total_votes}</span>
                                                                        </td>
                                                                        <td class="pe-4">
                                                                            <c:if test="${loop.index == 0}">
                                                                                <span class="badge bg-success">Leading</span>
                                                                            </c:if>
                                                                        </td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </div>

                                                    <!-- Voting Statistics -->
                                                    <div class="p-4 border-top">
                                                        <sql:query var="totalVotes" dataSource="${myDatasource}">
                                                            SELECT COUNT(DISTINCT v.STUDENT_ID) as vote_count
                                                            FROM VOTES v
                                                            JOIN CANDIDATES c ON v.CANDIDATE_ID = c.CANDIDATE_ID
                                                            WHERE c.ELECTION_ID = ?::BIGINT
                                                            <sql:param value="${election.election_id}"/>
                                                        </sql:query>
                                                        <c:set var="voteCount" value="${totalVotes.rows[0].vote_count}" />

                                                        <c:choose>
                                                            <c:when test="${election.election_type == 'campus'}">
                                                                <sql:query var="totalStudents" dataSource="${myDatasource}">
                                                                    SELECT COUNT(STUD_ID) as student_count
                                                                    FROM STUDENTS
                                                                    WHERE CAMPUS_ID = ?::INTEGER AND IS_ACTIVE = true
                                                                    <sql:param value="${election.campus_id}"/>
                                                                </sql:query>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <sql:query var="totalStudents" dataSource="${myDatasource}">
                                                                    SELECT COUNT(STUD_ID) as student_count
                                                                    FROM STUDENTS
                                                                    WHERE FACULTY_ID = ?::INTEGER AND IS_ACTIVE = true
                                                                    <sql:param value="${election.faculty_id}"/>
                                                                </sql:query>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <c:set var="studentCount" value="${totalStudents.rows[0].student_count}" />
                                                        <c:set var="percentage" value="${studentCount > 0 ? (voteCount * 100) / studentCount : 0}" />

                                                        <h6 class="fw-bold mb-3">Voting Statistics</h6>
                                                        <div class="row g-3">
                                                            <div class="col-md-4">
                                                                <div class="card border-1 bg-light">
                                                                    <div class="card-body">
                                                                        <p class="text-muted small mb-1">Total Votes Cast</p>
                                                                        <h4 class="text-primary fw-bold mb-0">${voteCount}</h4>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="card border-1 bg-light">
                                                                    <div class="card-body">
                                                                        <p class="text-muted small mb-1">Eligible Voters</p>
                                                                        <h4 class="text-primary fw-bold mb-0">${studentCount}</h4>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="card border-1 bg-light">
                                                                    <div class="card-body">
                                                                        <p class="text-muted small mb-1">Voter Participation</p>
                                                                        <h4 class="text-primary fw-bold mb-0"><fmt:formatNumber value="${percentage}" maxFractionDigits="1"/>%</h4>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </form>
                </div>

                <div class="d-none d-xl-block p-4 p-xl-5 overflow-auto no-scrollbar" style="width: 300px; min-width: 30%; background-color: #F3F9FE;">
                    <h3 class="h6 fw-bold text-dark text-uppercase">INFORMATION</h3>
                    <div class="row g-3 mt-2">
                        <div class="col-12">
                            <div class="card border-0 shadow-sm h-100 bg-white border border-1" style="border-radius: 1rem;">
                                <sql:query var="staff" dataSource="${myDatasource}">
                                    SELECT * FROM STAFFS WHERE STAFF_ID = ?::BIGINT
                                    <sql:param value="${election.created_by}"/>
                                </sql:query>
                                <c:set var="creator" value="${staff.rows[0]}" />
                                <div class="card-body p-3">
                                    <p class="text-dark m-0">Created By</p>
                                    <div class="d-flex align-items-center justify-content-center gap-3 h-100 px-4">
                                        <div class="rounded-circle bg-white overflow-hidden mb-2 shadow-sm" style="width: 2.8rem; height: 2.8rem;">
                                            <img src="${creator.profile_path}" alt="Profile" onerror="this.onerror=null; this.src='https://placehold.co/600x400?text=No+Image';" class="w-100 h-100 object-fit-cover bg-primary">
                                        </div>
                                        <div class="me-auto">
                                            <h3 class="h6 text-dark fw-semibold mb-0">${creator.full_name}</h3>
                                            <div class="badge rounded-pill px-3 py-1 mb-2 fw-normal bg-primary-subtle text-primary" style="font-size: 0.7rem;">
                                                Staff
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <hr class="mt-2 mb-0">
                                <div class="card-body p-3 d-flex flex-column gap-2">
                                    <div class="d-flex flex-grow-1">
                                        <p class="m-0 d-block">Created On</p>
                                        <p class="m-0 flex-grow-1 fw-semibold text-end">
                                            <fmt:parseDate  value="${election.created_at}" type="date" pattern="yyyy-MM-dd" var="parsedCreated" />
                                            <fmt:formatDate pattern="EEEE, MMM dd, yyyy" value="${parsedCreated}"/>
                                        </p>
                                    </div>
                                    <div class="d-flex flex-grow-1">
                                        <p class="m-0 d-block">Starting On</p>
                                        <p class="m-0 flex-grow-1 fw-semibold text-end">
                                            <fmt:parseDate  value="${election.start_date}" type="date" pattern="yyyy-MM-dd" var="parsedStart" />
                                            <fmt:formatDate pattern="EEEE, MMM dd, yyyy" value="${parsedStart}"/>
                                        </p>
                                    </div>
                                    <div class="d-flex flex-grow-1">
                                        <p class="m-0 d-block">Ending On</p>
                                        <p class="m-0 flex-grow-1 fw-semibold text-end">
                                            <fmt:parseDate  value="${election.end_date}" type="date" pattern="yyyy-MM-dd" var="parsedEnd" />
                                            <fmt:formatDate pattern="EEEE, MMM dd, yyyy" value="${parsedEnd}"/>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <c:if test="${election.status == 'active'}">
                            <form method="POST" class="col-12" onclick="if(confirm('Are you sure you want to CLOSE this election? Voting will be disabled.')) this.submit();">
                                <input type="hidden" name="election_id" value="${election.election_id}">
                                <input type="hidden" name="action" value="close_election">

                                <div role="button" id="close_election_btn" class="card border-0 shadow-sm h-100 bg-primary py-4 card-anim" style="border-radius: 1rem;">
                                    <div class="card-body px-3 py-2">
                                        <div class="d-flex align-items-center justify-content-center gap-4 h-100 px-4 text-dark">
                                            <svg width="50" height="50" viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path opacity="0.2" d="M13.625 50.375C11.325 48.075 12.85 43.25 11.675 40.425C10.5 37.6 6 35.125 6 32C6 28.875 10.45 26.5 11.675 23.575C12.9 20.65 11.325 15.925 13.625 13.625C15.925 11.325 20.75 12.85 23.575 11.675C26.4 10.5 28.875 6 32 6C35.125 6 37.5 10.45 40.425 11.675C43.35 12.9 48.075 11.325 50.375 13.625C52.675 15.925 51.15 20.75 52.325 23.575C53.5 26.4 58 28.875 58 32C58 35.125 53.55 37.5 52.325 40.425C51.1 43.35 52.675 48.075 50.375 50.375C48.075 52.675 43.25 51.15 40.425 52.325C37.6 53.5 35.125 58 32 58C28.875 58 26.5 53.55 23.575 52.325C20.65 51.1 15.925 52.675 13.625 50.375Z" fill="white"/>
                                                <path d="M43 26L28.325 40L21 33M13.625 50.375C11.325 48.075 12.85 43.25 11.675 40.425C10.5 37.6 6 35.125 6 32C6 28.875 10.45 26.5 11.675 23.575C12.9 20.65 11.325 15.925 13.625 13.625C15.925 11.325 20.75 12.85 23.575 11.675C26.4 10.5 28.875 6 32 6C35.125 6 37.5 10.45 40.425 11.675C43.35 12.9 48.075 11.325 50.375 13.625C52.675 15.925 51.15 20.75 52.325 23.575C53.5 26.4 58 28.875 58 32C58 35.125 53.55 37.5 52.325 40.425C51.1 43.35 52.675 48.075 50.375 50.375C48.075 52.675 43.25 51.15 40.425 52.325C37.6 53.5 35.125 58 32 58C28.875 58 26.5 53.55 23.575 52.325C20.65 51.1 15.925 52.675 13.625 50.375Z" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                            </svg>
                                            <div class="me-auto">
                                                <h3 class="h6 fw-semibold text-white mb-0">Close Election</h3>
                                                <p class="small opacity-75 text-white mb-0">End Voting Period</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </c:if>
                        
                        <c:if test="${not empty error}">
                            <div class="col-12">
                                <div class="alert alert-danger alert-dismissible fade show rounded-4" role="alert">
                                    <strong>Error!</strong> ${error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${not empty success}">
                            <div class="col-12">
                                <div class="alert alert-success alert-dismissible fade show rounded-4" role="alert">
                                    <strong>Success!</strong> ${success}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </div>
                        </c:if>
                    </div>
                
                </div>

            </main>
        </div>

        <!-- Candidate Profile Modal -->
        <div class="modal fade" id="candidateModal" tabindex="-1" aria-labelledby="candidateModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header border-bottom">
                        <h5 class="modal-title fw-bold" id="candidateModalLabel">Candidate Profile</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-md-4 text-center">
                                <div class="rounded-4 overflow-hidden mb-3" style="aspect-ratio: 1;">
                                    <img id="candidatePhoto" src="https://placehold.co/600x400?text=No+Image" alt="Candidate" class="w-100 h-100 object-fit-cover">
                                </div>
                            </div>
                            <div class="col-md-8">
                                <h4 id="candidateName" class="fw-bold mb-1"></h4>
                                <p id="candidateStudNumber" class="text-muted small mb-3"></p>
                                <div class="mb-3">
                                    <label class="form-label small fw-semibold">Slogan</label>
                                    <p id="candidateSlogan" class="mb-0 fst-italic"></p>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label small fw-semibold">Status</label>
                                    <div id="candidateStatusBadge"></div>
                                </div>
                            </div>
                            <div class="col-12">
                                <label class="form-label small fw-semibold">Manifesto</label>
                                <div id="candidateManifesto" class="p-3 pt-1 rounded-3 small" style="max-height: 200px; overflow-y: auto;"></div>
                            </div>
                            <div class="col-12">
                                <label class="form-label small fw-semibold">Campaign Banner</label>
                                <div class="pt-1 rounded-4 overflow-hidden mb-3" style="aspect-ratio: 2/1;">
                                    <img id="bannerPhoto" src="" alt="Banner" class="w-100 h-100 object-fit-cover">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer border-top">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <%-- Javascripts  --%>
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>

        <script>
            function loadCandidateProfile(candidateId, fullName, studNumber, status, slogan, manifesto, photoUrl, bannerUrl) {
                $('#candidateName').text(fullName);
                $('#candidateStudNumber').text('Student ID: ' + studNumber);
                $('#candidateSlogan').text(slogan || 'No slogan provided');
                $('#candidateManifesto').text(manifesto || 'No manifesto provided');
                
                if (photoUrl && photoUrl.trim()) {
                    $('#candidatePhoto').attr('src', photoUrl);
                } else {
                    $('#candidatePhoto').attr('src', 'https://placehold.co/600x400?text=No+Image');
                }

                if (bannerUrl && bannerUrl.trim()) {
                    $('#bannerPhoto').attr('src', bannerUrl);
                } else {
                    $('#bannerPhoto').attr('src', 'https://placehold.co/600x400?text=No+Image');
                }

                let statusBadge = '';
                switch(status) {
                    case 'approved':
                        statusBadge = '<span class="px-3 py-1 badge bg-primary">Approved</span>';
                        break;
                    case 'pending':
                        statusBadge = '<span class="px-3 py-1 badge bg-primary-subtle text-dark">Pending</span>';
                        break;
                    case 'rejected':
                        statusBadge = '<span class="px-3 py-1 badge bg-danger">Rejected</span>';
                        break;
                    case 'withdrawn':
                        statusBadge = '<span class="px-3 py-1 badge bg-dark text-white">Withdrawn</span>';
                        break;
                }
                $('#candidateStatusBadge').html(statusBadge);
            }
        </script>
    </body>
</html>