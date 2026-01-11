<%-- 
    Document   : election.modify
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
                    <h1 class="h4 fw-bold mb-0">Modify Election</h1>

                    <a href="${pageContext.request.contextPath}/elections" type="button" class="btn rounded-pill px-4 bg-white border border-1 card-anim" style="width: fit-content;">
                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M4.16675 9.99992H15.8334" stroke="#121026" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M4.16675 10L9.16675 15" stroke="#121026" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M4.16675 10L9.16675 5" stroke="#121026" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        Return
                    </a>

                    <form method="POST" id="modify_form">
                        <input type="hidden" name="action" value="update_election"/>
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
                                                <input type="hidden" name="campus_id" value="${camp.campus_id}"/>
                                            </div>
                                            
                                            <div class="col-md-7">
                                                <div class="d-flex align-items-center gap-2">
                                                    <label class="mb-1"><small>Faculty Specific?</small></label>
                                                    <div class="form-check form-switch m-0">
                                                        <input class="form-check-input" type="checkbox" id="facultySwitch" name="is_faculty_specific" 
                                                            <c:if test="${election.election_type == 'faculty'}">checked</c:if>>
                                                    </div>
                                                </div>
                                                <sql:query var="facultyList" dataSource="${myDatasource}">
                                                    SELECT * FROM FACULTY WHERE CAMPUS_ID = ?::integer
                                                    <sql:param value="${election.campus_id}"/>
                                                </sql:query>
                                                <select name="faculty_id" class="form-control" id="facultySelect" 
                                                    <c:if test="${election.election_type == 'campus'}">disabled</c:if> <c:if test="${election.election_type == 'faculty'}">required</c:if>>
                                                    <option value="">
                                                        <c:choose>
                                                            <c:when test="${election.election_type == 'campus'}">Select Faculty (Disabled)</c:when>
                                                            <c:otherwise>Select Faculty</c:otherwise>
                                                        </c:choose>
                                                    </option>
                                                    <c:forEach var="faculty" items="${facultyList.rows}">
                                                        <option value="${faculty.faculty_id}" <c:if test="${faculty.faculty_id == election.faculty_id}">selected</c:if>>
                                                            ${faculty.faculty_code} - ${faculty.faculty_name}
                                                        </option> 
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="col-md-12">
                                                <label class="mb-1"><small>Election Title</small></label>
                                                <input type="text" name="title" class="form-control" value="${election.title}" required/>
                                            </div>

                                            <div class="col-12">
                                                <label class="mb-1"><small>Election Description</small></label>
                                                <textarea id="description" name="description" class="form-control" rows="3" maxlength="5000" required style="field-sizing: content;">${election.description}</textarea>
                                                <small class="text-secondary"><span id="charCount">0</span> / 5000 </small>
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
                                                <input type="text" name="session" class="form-control" value="${election.session}" required/>
                                            </div>
                                            
                                            <div class="col-md-6">
                                                <label class="mb-1"><small>Max Votes per Voter</small></label>
                                                <input type="number" name="max_votes" class="form-control" value="${election.max_votes}" min="1" required/>
                                            </div>

                                            <div class="col-md-6">
                                                <label class="mb-1"><small>Start Date & Time</small></label>
                                                <div class="input-group" id="startDatePicker" data-td-target-input="nearest" data-td-target-toggle="nearest">
                                                    <input id="startDateInput" name="start_date" type="text" class="form-control" data-td-target="#startDatePicker" value="${election.start_date.toString().replace('T', ' ')}" required/>
                                                    <span class="input-group-text" data-td-target="#startDatePicker" data-td-toggle="datetimepicker">
                                                        <i class="fa fa-calendar text-dark"></i>
                                                    </span>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <label class="mb-1"><small>End Date & Time</small></label>
                                                <div class="input-group" id="endDatePicker" data-td-target-input="nearest" data-td-target-toggle="nearest">
                                                    <input id="endDateInput" name="end_date" type="text" class="form-control" data-td-target="#endDatePicker" value="${election.end_date.toString().replace('T', ' ')}" required/>
                                                    <span class="input-group-text" data-td-target="#endDatePicker" data-td-toggle="datetimepicker">
                                                        <i class="fa fa-calendar text-dark"></i>
                                                    </span>
                                                </div>
                                            </div>

                                            <div class="col-12 mt-4">
                                                <div class="card bg-light border-1">
                                                    <div class="card-body py-2 px-3">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="checkbox" name="candidacy_open" id="openCandidacy" value="true" <c:if test="${election.candidacy_open}">checked</c:if>>
                                                            <label class="form-check-label fw-semibold" for="openCandidacy">
                                                                Enable Open Candidacy
                                                            </label>
                                                            <br><small class="text-muted">If checked, students can nominate themselves as candidates.</small>
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
                                                <div class="mb-0 text-center text-muted py-3">
                                                    No student has registered as a candidate for this election.
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
                                        <div class="accordion-body bg-white">
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
                                                    <div class="alert alert-info rounded-4 mb-0" role="alert">
                                                        <strong>No Approved Candidates</strong> - There are no approved candidates yet for this election.
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="table-responsive">
                                                        <table class="table table-hover mb-0">
                                                            <thead class="table-light">
                                                                <tr>
                                                                    <th scope="col" style="width: 25%;">Student Name</th>
                                                                    <th scope="col" style="width: 20%;">Student Number</th>
                                                                    <th scope="col" style="width: 25%;">Position</th>
                                                                    <th scope="col" style="width: 15%;">Total Votes</th>
                                                                    <th scope="col" style="width: 15%;"></th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach var="candidate" items="${approvedCandidates.rows}" varStatus="loop">
                                                                    <tr>
                                                                        <td class="fw-semibold">${candidate.full_name}</td>
                                                                        <td>${candidate.stud_number}</td>
                                                                        <td>${candidate.elected_position}</td>
                                                                        <td>
                                                                            <span class="badge bg-primary">${candidate.total_votes}</span>
                                                                        </td>
                                                                        <td>
                                                                            <c:if test="${loop.index == 0}">
                                                                                <span class="badge bg-success">Leading</span>
                                                                            </c:if>
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

                        <c:if test="${election.status == 'upcoming'}">
                            <div class="col-12">
                                <div role="button" id="modify_btn" class="card border-0 shadow-sm h-100 bg-primary py-4 card-anim" style="border-radius: 1rem;">
                                    <div class="card-body px-3 py-2">
                                        <div class="d-flex align-items-center justify-content-center gap-4 h-100 px-4 text-white">
                                            <svg width="30" height="30" viewBox="0 0 800 800" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M690.333 109.667C680.736 100.147 669.254 92.7391 656.626 87.9172C643.997 83.0953 630.5 80.9663 617 81.6667C589.531 83.1902 563.671 95.1074 544.667 115L315.333 343C313.809 344.675 312.57 346.59 311.667 348.667C310.352 350.547 309.235 352.557 308.333 354.667L266.667 490.667C265.181 495.744 264.925 501.103 265.921 506.299C266.916 511.495 269.134 516.379 272.391 520.548C275.648 524.718 279.851 528.051 284.652 530.275C289.453 532.498 294.714 533.546 300 533.333C303.092 533.82 306.241 533.82 309.333 533.333L442.667 494.333L448.667 491C450.744 490.097 452.658 488.858 454.333 487.333L683.333 258C703.226 238.996 715.143 213.136 716.667 185.667C717.968 171.852 716.291 157.919 711.749 144.809C707.206 131.698 699.903 119.714 690.333 109.667Z" fill="currentColor"/>
                                                <path d="M666.667 733.333H133.333C115.652 733.333 98.6954 726.31 86.193 713.807C73.6905 701.305 66.6667 684.348 66.6667 666.667V133.333C66.6667 115.652 73.6905 98.6954 86.193 86.193C98.6954 73.6905 115.652 66.6667 133.333 66.6667H400C408.841 66.6667 417.319 70.1786 423.57 76.4299C429.821 82.6811 433.333 91.1595 433.333 100C433.333 108.841 429.821 117.319 423.57 123.57C417.319 129.822 408.841 133.333 400 133.333H133.333V666.667H666.667V400C666.667 391.16 670.179 382.681 676.43 376.43C682.681 370.179 691.16 366.667 700 366.667C708.841 366.667 717.319 370.179 723.57 376.43C729.822 382.681 733.333 391.16 733.333 400V666.667C733.333 684.348 726.31 701.305 713.807 713.807C701.305 726.31 684.348 733.333 666.667 733.333Z" fill="currentColor"/>
                                            </svg>
                                            <div class="me-auto">
                                                <h3 class="h6 fw-semibold mb-0">Modify Election</h3>
                                                <p class="small opacity-75 mb-0">Update Election Details</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <form method="POST" class="col-12" onclick="if(confirm('Are you sure you want to BEGIN the voting period?')) this.submit();">
                                <input type="hidden" name="election_id" value="${election.election_id}">
                                <input type="hidden" name="action" value="start_election">
                                
                                <div role="button" id="start_election_btn" class="card border-0 shadow-sm h-100 bg-dark py-4 card-anim" style="border-radius: 1rem;">
                                    <div class="card-body px-3 py-2">
                                        <div class="d-flex align-items-center justify-content-center gap-4 h-100 px-4 text-white">
                                            <svg width="30" height="30" viewBox="0 0 60 60" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M10 32.5C19.1755 33.5904 26.4096 40.8245 27.5 50C31.9927 47.4099 34.8288 42.683 35 37.5C43.5844 34.4801 49.5046 26.5866 50 17.5C50 13.3579 46.6421 10 42.5 10C33.4134 10.4954 25.5199 16.4156 22.5 25C17.317 25.1712 12.5901 28.0073 10 32.5" stroke="white" stroke-opacity="0.9" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                                                <path d="M17.5002 35C12.1775 38.0049 9.21054 43.9389 10.0002 50C16.0613 50.7896 21.9953 47.8226 25.0002 42.5" stroke="white" stroke-opacity="0.9" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                                                <circle cx="37.5" cy="22.5" r="2.5" stroke="white" stroke-opacity="0.9" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                                            </svg>
                                            <div class="me-auto">
                                                <h3 class="h6 fw-semibold mb-0">Start Election</h3>
                                                <p class="small opacity-75 mb-0">Begin Voting Period</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>

                            <form method="POST" class="col-12" onclick="if(confirm('WARNING: Are you sure you want to CANCEL this election? This action cannot be undone.')) this.submit();">
                                <input type="hidden" name="election_id" value="${election.election_id}">
                                <input type="hidden" name="action" value="cancel_election">

                                <div role="button" id="cancel_election_btn" class="card border-0 shadow-sm h-100 bg-danger py-4 card-anim" style="border-radius: 1rem;">
                                    <div class="card-body px-3 py-2">
                                        <div class="d-flex align-items-center justify-content-center gap-4 h-100 px-4 text-white">
                                            <svg width="30" height="30" viewBox="0 0 60 60" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M10 32.5C19.1755 33.5904 26.4096 40.8245 27.5 50C31.9927 47.4099 34.8288 42.683 35 37.5C43.5844 34.4801 49.5046 26.5866 50 17.5C50 13.3579 46.6421 10 42.5 10C33.4134 10.4954 25.5199 16.4156 22.5 25C17.317 25.1712 12.5901 28.0073 10 32.5" stroke="white" stroke-opacity="0.9" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                                                <path d="M17.5002 35C12.1775 38.0049 9.21054 43.9389 10.0002 50C16.0613 50.7896 21.9953 47.8226 25.0002 42.5" stroke="white" stroke-opacity="0.9" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                                                <circle cx="37.5" cy="22.5" r="2.5" stroke="white" stroke-opacity="0.9" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                                            </svg>
                                            <div class="me-auto">
                                                <h3 class="h6 fw-semibold mb-0">Cancel Election</h3>
                                                <p class="small opacity-75 mb-0">Remove Election Posting</p>
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
        <form method="POST">
            <input type="hidden" name="election_id" value="${election.election_id}">
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
                                        <img id="candidatePhoto" src="https://placehold.co/600x400?text=No+Image'" alt="Candidate" class="w-100 h-100 object-fit-cover">
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
                                    <div class="pt-1 rounded-4 overflow-hidden mb-3" style="aspect-ratio: 1;">
                                        <img id="bannerPhoto" src="" alt="Banner" class="w-100 h-100 object-fit-cover">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer border-top">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <input type="hidden" name="candidate_id" id="candidateIdHidden" value="">
                            <button type="submit" name="action" value="approve_candidate" onclick="return confirm('Approve this candidate?')" id="approveCandidateBtn" class="btn btn-primary">Approve</button>
                            <button type="submit" name="action" value="reject_candidate" onclick="return confirm('Reject this candidate?')" id="rejectCandidateBtn" class="btn btn-dark">Reject</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <%-- Javascripts  --%>
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>

        <script>
            function loadCandidateProfile(candidateId, fullName, studNumber, status, slogan, manifesto, photoUrl, bannerUrl) {
                $('#candidateIdHidden').val(candidateId);
                $('#candidateName').text(fullName);
                $('#candidateStudNumber').text('Student ID: ' + studNumber);
                $('#candidateSlogan').text(slogan || 'No slogan provided');
                $('#candidateManifesto').text(manifesto || 'No manifesto provided');
                
                if (photoUrl && photoUrl.trim() !== '') {
                    $('#candidatePhoto').attr('src', photoUrl);
                } else {
                    $('#candidatePhoto').attr('src', 'https://placehold.co/600x400?text=No+Image');
                }

                if (bannerUrl && bannerUrl.trim() !== '') {
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

                if (status === 'approved') {
                    $('#approveCandidateBtn').prop('disabled', true);
                    $('#rejectCandidateBtn').prop('disabled', false);
                } else if (status === 'rejected') {
                    $('#approveCandidateBtn').prop('disabled', false);
                    $('#rejectCandidateBtn').prop('disabled', true);
                } else {
                    $('#approveCandidateBtn').prop('disabled', false);
                    $('#rejectCandidateBtn').prop('disabled', false);
                }
            }

            $(document).ready(function () {
                const pickerOptions = {
                    display: {
                        components: {
                            calendar: true,
                            date: true,
                            seconds: false,
                            useTwentyfourHour: true
                        },
                        theme: 'light'
                    },
                    localization: {
                        format: 'yyyy-MM-dd HH:mm:00',
                    }
                };

                const startPicker = new tempusDominus.TempusDominus(document.getElementById('startDatePicker'), pickerOptions);
                const endPicker = new tempusDominus.TempusDominus(document.getElementById('endDatePicker'), pickerOptions);

                document.getElementById('startDatePicker').addEventListener(tempusDominus.Namespace.events.change, (e) => {
                    endPicker.updateOptions({
                        restrictions: {
                            minDate: e.detail.date,
                        },
                    });
                });

                document.getElementById('endDatePicker').addEventListener(tempusDominus.Namespace.events.change, (e) => {
                    startPicker.updateOptions({
                        restrictions: {
                            maxDate: e.detail.date,
                        },
                    });
                });

                const $textarea = $('#description');
                const maxLength = $textarea.attr('maxlength');

                function updateCounter() {
                    const length = $textarea.val().length;
                    $('#charCount').text(length);
                    if (length >= maxLength) {
                        $('#charCount').addClass('text-danger');
                    } else {
                        $('#charCount').removeClass('text-danger');
                    }
                }

                updateCounter();

                $textarea.on('input', function () {
                    updateCounter();
                });

                $('#facultySwitch').on('change', function() {
                    const isChecked = $(this).is(':checked');
                    const $select = $('#facultySelect');
                    
                    $select.prop('disabled', !isChecked)
                        .prop('required', isChecked);
                    
                    if (isChecked) {
                        $select.find('option:first').text('Select Faculty');
                    } else {
                        $select.val('').find('option:first').text('Select Faculty (Disabled)');
                    }
                });

                $('#modify_btn').on('click', function() {
                    if (!confirm('Are you sure you want to modify this election?')) {
                        return;
                    }
                    const form = $('#modify_form')[0]; 
                    if (form.reportValidity()) { 
                        form.submit(); 
                    }
                });

            });
        </script>
    </body>
</html>