<%-- 
    Document   : index
    Created on : Dec 25, 2025, 9:56:32 PM
    Author     : ASUS
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Elections" />
    
    <%-- Get Student Total Votes Count --%>
    <sql:query dataSource="${myDatasource}" var="totalVotes">
        SELECT COUNT(V.*) AS COUNT
        FROM VOTES V
        JOIN CANDIDATES C ON V.CANDIDATE_ID = C.CANDIDATE_ID
        JOIN ELECTIONS E ON C.ELECTION_ID = E.ELECTION_ID
        WHERE E.ELECTION_ID = ?
        <sql:param value="${election.election_id}" />
    </sql:query>
    <c:set var="counts" value="${totalVotes.rows[0]}" />

    <%-- Get Candidates with Vote Counts --%>
    <sql:query var="candidates" dataSource="${myDatasource}">
        SELECT 
            C.CANDIDATE_ID, 
            C.STUDENT_ID, 
            C.STATUS, 
            C.SLOGAN,
            C.MANIFESTO,
            C.PHOTO_URL,
            C.BANNER_URL,
            S.FULL_NAME,
            S.STUD_NUMBER,
            COUNT(V.*) AS VOTE_COUNT,
            CASE 
                WHEN ${counts.count} > 0 THEN ROUND((COUNT(V.*)::NUMERIC / ${counts.count}) * 100, 0)
                ELSE 0 
            END AS PERCENTAGE
        FROM CANDIDATES C
        JOIN STUDENTS S ON C.STUDENT_ID = S.STUD_ID
        LEFT JOIN VOTES V ON C.CANDIDATE_ID = V.CANDIDATE_ID
        WHERE C.ELECTION_ID = ?::BIGINT
        GROUP BY C.CANDIDATE_ID, C.STUDENT_ID, C.STATUS, C.SLOGAN, C.MANIFESTO, C.PHOTO_URL, C.BANNER_URL, S.FULL_NAME, S.STUD_NUMBER
        ORDER BY VOTE_COUNT DESC, C.CREATED_AT DESC
        <sql:param value="${election.election_id}"/>
    </sql:query>

    <body style="background-color: #121026">
        <div class="d-flex vh-100 overflow-hidden">

            <div class="h-100">
                <%@ include file="/WEB-INF/jspf/nav_stud.jspf" %>
            </div>

            <main class="d-flex flex-grow-1 overflow-hidden">
                
                <div class="flex-grow-1 rounded-start-5 p-4 p-xl-5 overflow-auto no-scrollbar d-flex flex-column gap-4" style="background-color: #F3F9FE;">
                    <h1 class="h4 fw-bold mb-0">Closed Election</h1>

                    <a href="${pageContext.request.contextPath}/elections" type="button" class="btn rounded-pill px-4 bg-white border border-1 card-anim" style="width: fit-content;">
                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M4.16675 9.99992H15.8334" stroke="#121026" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M4.16675 10L9.16675 15" stroke="#121026" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M4.16675 10L9.16675 5" stroke="#121026" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        Return
                    </a>

                    <div class="d-flex flex-column gap-2">
                        <h1 class="lh-1">${election.title}</h1>
                        <div class="d-flex mb-2 flex-wrap gap-2">
                            <c:choose>
                                <c:when test="${election.status == 'upcoming'}">
                                    <span class="badge px-3 py-2" style="background-color: #4c3d99; color: white; font-size: 0.75rem; font-weight: 600; width: fit-content; ">
                                        UPCOMING
                                    </span>
                                </c:when>
                                <c:when test="${election.status == 'active'}">
                                    <span class="badge px-3 py-2" style="background-color: #7367F0; color: white; font-size: 0.75rem; font-weight: 600; width: fit-content; ">
                                        ACTIVE
                                    </span>
                                </c:when>
                                <c:when test="${election.status == 'closed'}">
                                    <span class="badge px-3 py-2" style="background-color: #d4d4f7; color: #5b4fc9; font-size: 0.75rem; font-weight: 600; width: fit-content; ">
                                        CLOSED
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge px-3 py-2" style="background-color: #9CA3AF; color: white; font-size: 0.75rem; font-weight: 600; width: fit-content; ">
                                        ${fn.toUpperCase(election.status)}
                                    </span>
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${hasVoted}">
                                <span class="badge bg-primary-subtle text-dark border border-1 border-dark px-3 py-2">
                                    VOTED
                                </span>
                            </c:if>
                            <span class="badge bg-primary px-3 py-2">
                                SESSION ${election.session}
                            </span>
                            <c:if test="${not empty loc.CAMPUS_NAME}">
                                <span class="badge bg-primary px-3 py-2">
                                    ${loc.CAMPUS_NAME}
                                </span>
                            </c:if>
                            <c:if test="${not empty loc.FACULTY_NAME}">
                                <span class="badge bg-primary px-3 py-2">
                                    ${loc.FACULTY_NAME}
                                </span>
                            </c:if>
                        </div>
                        <p>${election.description}</p>
                    </div>
    
                    <%-- Candidates List --%>
                    <h1 class="h5 fw-bold mb-0">Candidates</h1>
                    <form method="post">
                        <input type="hidden" name="action" value="vote_election">
                        <input type="hidden" name="election_id" value="${election.election_id}" />
                        <input type="hidden" name="student_id" value="${sessionScope.loggedUser.stud_id}" />
                        <div class="d-flex flex-column gap-3">
                            <c:forEach var="candidate" items="${candidates.rows}" varStatus="loop">
                                <div class="card w-100 ${loop.index == 0 ? 'border border-1 border-primary bg-primary-subtle' : 'bg-light'}">
                                    <div class="card-body p-4">
                                        <div class="d-flex flex-column flex-lg-row align-items-center gap-3">
                                            <div class="rounded-circle bg-white overflow-hidden shadow-sm" style="width: 4rem; height: 4rem;">
                                                <img src="${candidate.photo_url}" alt="Candidate" onerror="this.onerror=null; this.src='https://placehold.co/600x400?text=No+Image';" class="w-100 h-100 object-fit-cover">
                                            </div>
                                            <div class="flex-grow-1">
                                                <h3 class="h5 text-dark fw-semibold d-flex flex-column flex-lg-row gap-lg-3 mb-1">
                                                    ${candidate.full_name}
                                                    <a href="#" class="bg-transparent text-primary small text-decoration-none d-flex flex-row align-items-center gap-1"
                                                        data-bs-toggle="modal" 
                                                        data-bs-target="#candidateModal"
                                                        data-candidate-id="${candidate.candidate_id}"
                                                        data-candidate-name="${candidate.full_name}"
                                                        data-candidate-stud-number="${candidate.stud_number}"
                                                        data-candidate-slogan="${candidate.slogan}"
                                                        data-candidate-manifesto="${candidate.manifesto}"
                                                        data-candidate-photo-url="${candidate.photo_url}"
                                                        data-candidate-banner-url="${candidate.banner_url}"
                                                        data-candidate-status="${candidate.status}">
                                                        <svg width="17" height="20" viewBox="0 0 17 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M6.16683 5.83325H2.00016C1.07969 5.83325 0.333496 6.57944 0.333496 7.49992V14.9999C0.333496 15.9204 1.07969 16.6666 2.00016 16.6666H9.50016C10.4206 16.6666 11.1668 15.9204 11.1668 14.9999V10.8333" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                                            <path d="M5.3335 11.6666L13.6668 3.33325" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                                            <path d="M9.5 3.33325H13.6667V7.49992" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                                        </svg>
                                                        Open Profile
                                                    </a>
                                                </h3>
                                                <p class="fs-6 text-muted mb-0">${candidate.slogan}</p>
                                            </div>
                                            <div class="d-flex flex-row align-items-center justify-content-center text-center gap-3 me-3">
                                                <c:choose>
                                                    <c:when test="${candidate.status == 'withdrawn'}">
                                                        <svg width="40" height="40" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg" class="m-0">
                                                            <circle cx="20" cy="20" r="15" stroke="#6c757d80" stroke-width="1.5"/>
                                                            <path d="M15 20H25" stroke="#6c757d80" stroke-width="1.5" stroke-linecap="round"/>
                                                        </svg>
                                                        <span class="fw-semibold text-secondary opacity-75 fs-4" style="color: #6c757d80">WITHDRAWN</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="d-flex flex-column align-items-center">
                                                            <h2 class="display-6 fw-bold text-dark mb-0">${candidate.percentage}%</h2>
                                                            <p class="text-muted small mb-0">${candidate.vote_count} Votes</p>
                                                        </div>
                                                        <c:if test="${loop.index == 0}">
                                                            <svg width="64" height="64" viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                <path opacity="0.2" d="M13.625 50.375C11.325 48.075 12.85 43.25 11.675 40.425C10.5 37.6 6 35.125 6 32C6 28.875 10.45 26.5 11.675 23.575C12.9 20.65 11.325 15.925 13.625 13.625C15.925 11.325 20.75 12.85 23.575 11.675C26.4 10.5 28.875 6 32 6C35.125 6 37.5 10.45 40.425 11.675C43.35 12.9 48.075 11.325 50.375 13.625C52.675 15.925 51.15 20.75 52.325 23.575C53.5 26.4 58 28.875 58 32C58 35.125 53.55 37.5 52.325 40.425C51.1 43.35 52.675 48.075 50.375 50.375C48.075 52.675 43.25 51.15 40.425 52.325C37.6 53.5 35.125 58 32 58C28.875 58 26.5 53.55 23.575 52.325C20.65 51.1 15.925 52.675 13.625 50.375Z" fill="#7367F0"/>
                                                                <path d="M43 26L28.325 40L21 33M13.625 50.375C11.325 48.075 12.85 43.25 11.675 40.425C10.5 37.6 6 35.125 6 32C6 28.875 10.45 26.5 11.675 23.575C12.9 20.65 11.325 15.925 13.625 13.625C15.925 11.325 20.75 12.85 23.575 11.675C26.4 10.5 28.875 6 32 6C35.125 6 37.5 10.45 40.425 11.675C43.35 12.9 48.075 11.325 50.375 13.625C52.675 15.925 51.15 20.75 52.325 23.575C53.5 26.4 58 28.875 58 32C58 35.125 53.55 37.5 52.325 40.425C51.1 43.35 52.675 48.075 50.375 50.375C48.075 52.675 43.25 51.15 40.425 52.325C37.6 53.5 35.125 58 32 58C28.875 58 26.5 53.55 23.575 52.325C20.65 51.1 15.925 52.675 13.625 50.375Z" stroke="#7367F0" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                                            </svg>
                                                        </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="d-flex justify-content-start mt-4 gap-2">
                            <a href="${pageContext.request.contextPath}/elections" type="button" class="btn btn-primary rounded-pill px-4 py-2 bg-transparent text-dark border-1 border-dark">
                                Back
                            </a>
                        </div>
                    </form>
                </div>

                <%-- Information --%>
                <div class="d-none d-xl-block p-4 p-xl-5" style="width: 300px; min-width: 30%; background-color: #F3F9FE;">
                    <h3 class="h6 fw-bold text-dark text-uppercase">INFORMATION</h3>
                    <div class="row g-3">
                        <div class="col-12">
                            <div class="card border-0 shadow-sm h-100" style="background: linear-gradient(135deg, #1e1b4b 0%, #2d2a5a 100%); border-radius: 1rem;">
                                <div class="card-body px-3 py-2">
                                    <div class="d-flex align-items-center justify-content-center gap-3 h-100 px-4">
                                        <div class="me-auto">
                                            <h3 class="h6 text-white fw-semibold mb-0">Students</h3>
                                            <p class="small text-white opacity-75 mb-0">Total Votes</p>
                                        </div>
                                        <div class="display-4 fw-bold text-white">${counts.count}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12">
                            <sql:query var="staff" dataSource="${myDatasource}">
                                SELECT * FROM STAFFS WHERE STAFF_ID = ?::BIGINT
                                <sql:param value="${election.created_by}"/>
                            </sql:query>
                            <c:set var="creator" value="${staff.rows[0]}" />
                            <div class="card border-0 shadow-sm h-100 bg-white border border-1" style="border-radius: 1rem;">
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
                                </div>
                            </div>
                        </div>
                        <c:if test="${not empty error}">
                            <div class="col-12">
                                <div class="alert alert-danger alert-dismissible fade show rounded-4" role="alert">
                                    <strong>Error!</strong> ${error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </main>
        </div>

        <%-- Candidate Profile Modal --%>
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
                                    <img id="candidatePhoto" src="" alt="Candidate" onerror="this.onerror=null; this.src='https://placehold.co/600x400?text=No+Image';" class="w-100 h-100 object-fit-cover">
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
                                    <img id="bannerPhoto" src="" alt="Banner" onerror="this.onerror=null;this.src='https://placehold.co/600x400?text=No+Image';" class="w-100 h-100 object-fit-cover">
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
            $(document).ready(function () {
                $('#candidateModal').on('show.bs.modal', function(event) {
                    var trigger = $(event.relatedTarget);
                    var candidateId = trigger.data('candidateId');
                    var fullName = trigger.data('candidateName');
                    var slogan = trigger.data('candidateSlogan');
                    var studNumber = trigger.data('candidateStudNumber');
                    var manifesto = trigger.data('candidateManifesto');
                    var photo = trigger.data('candidatePhotoUrl');
                    var banner = trigger.data('candidateBannerUrl');
                    var status = trigger.data('candidateStatus');

                    // Now populate your modal dynamically
                    $('#candidateIdHidden').val(candidateId);
                    $('#candidateName').text(fullName);
                    $('#candidateStudNumber').text('Student ID: ' + studNumber);
                    $('#candidateSlogan').text(slogan || 'No slogan provided');
                    $('#candidateManifesto').text(manifesto || 'No manifesto provided');
                
                    if (photo && photo.trim() !== '') {
                        $('#candidatePhoto').attr('src', photo);
                    } else {
                        $('#candidatePhoto').attr('src', 'https://placehold.co/600x400?text=No+Image');
                    }
                    if (banner && banner.trim() !== '') {
                        $('#bannerPhoto').attr('src', banner);
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
                });
            });
        </script>
    </body>
</html>
