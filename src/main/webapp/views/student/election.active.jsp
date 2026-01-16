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

    <%-- Get Candidates List --%>
    <sql:query var="candidates" dataSource="${myDatasource}">
        SELECT C.CANDIDATE_ID, C.STUDENT_ID, C.STATUS, C.SLOGAN, C.MANIFESTO, C.PHOTO_URL, C.BANNER_URL, S.FULL_NAME, S.STUD_NUMBER
        FROM CANDIDATES C
        JOIN STUDENTS S ON C.STUDENT_ID = S.STUD_ID
        WHERE C.ELECTION_ID = ?::BIGINT
        ORDER BY C.CREATED_AT DESC
        <sql:param value="${election.election_id}"/>
    </sql:query>

    <%-- Check if Student has Voted --%>
    <sql:query var="voteCheck" dataSource="${myDatasource}">
        SELECT V.* 
        FROM VOTES V
        JOIN CANDIDATES C ON V.CANDIDATE_ID = C.CANDIDATE_ID
        WHERE V.STUDENT_ID = ? AND C.ELECTION_ID = ?;
        <sql:param value="${loggedUser.stud_id}"/>
        <sql:param value="${election.election_id}"/>
    </sql:query>
    <c:set var="hasVoted" value="${voteCheck.rowCount > 0}" />

    <body style="background-color: #121026">
        <div class="d-flex vh-100 overflow-hidden">

            <div class="h-100">
                <%@ include file="/WEB-INF/jspf/nav_stud.jspf" %>
            </div>

            <main class="d-flex flex-grow-1 overflow-hidden">
                
                <div class="flex-grow-1 rounded-start-5 p-4 p-xl-5 overflow-auto no-scrollbar d-flex flex-column gap-4" style="background-color: #F3F9FE;">
                    <h1 class="h4 fw-bold mb-0">Active Election</h1>

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
                                <c:set var="checked" value="false" />

                                <c:forEach var="voted" items="${voteCheck.rows}">
                                    <c:if test="${voted.candidate_id == candidate.candidate_id}">
                                        <c:set var="checked" value="true" />
                                    </c:if>
                                </c:forEach>

                                <label class="card candidate-card w-100 ${checked ? 'bg-primary-subtle text-dark border border-1 border-primary' : ''}" 
                                       style="cursor: ${(candidate.status == 'withdrawn' || hasVoted) ? 'not-allowed' : 'pointer'};">
                                    <div class="card-body p-3">
                                        <div class="d-flex flex-column flex-lg-row align-items-center justify-content-center gap-3 h-100 px-3">
                                            <div class="rounded-circle bg-white overflow-hidden shadow-sm" style="width: 4rem; height: 4rem;">
                                                <img src="${candidate.photo_url}" alt="Candidate" onerror="this.onerror=null; this.src='https://placehold.co/600x400?text=No+Image';" class="w-100 h-100 object-fit-cover">
                                            </div>
                                            <div class="me-auto">
                                                <h3 class="h5 text-dark fw-semibold d-flex flex-column flex-lg-row gap-lg-3 mb-1">${candidate.full_name}
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

                                            <c:choose>
                                                <c:when test="${candidate.status == 'withdrawn'}">
                                                    <div class="d-flex flex-column align-items-center">
                                                        <svg width="40" height="40" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <circle cx="20" cy="20" r="15" stroke="#6c757d80" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                                            <path d="M15 20.0001H25" stroke="#6c757d80" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                                        </svg>
                                                        <label class="fw-semibold text-secondary text-opacity-50">Withdrawn</label>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="form-check me-3">
                                                        <input type="checkbox" name="candidateId" value="${candidate.candidate_id}" class="form-check-input fs-5 border-secondary" 
                                                            ${hasVoted ? 'disabled="disabled"' : ''}
                                                            ${checked ? 'checked="checked"' : ''}
                                                            ${hasVoted ? '' : 'required'} />
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </label>
                            </c:forEach>
                            <div class="invalid-feedback">
                                Please select a candidate to vote for.
                            </div>
                        </div>
                        <div class="d-flex justify-content-start mt-4 gap-2">
                            <a href="${pageContext.request.contextPath}/elections" type="button" class="btn btn-primary rounded-pill px-4 py-2 bg-transparent text-dark border-1 border-dark">
                                Back
                            </a>
                            <c:if test="${hasVoted == false}">
                                <button type="submit" class="btn btn-dark rounded-pill px-4 py-2">
                                    Submit Your Vote
                                </button>
                            </c:if>
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
                            <div class="card border-0 shadow-sm h-100 bg-white border border-1" style="border-radius: 1rem;">
                                <div class="card-body p-3">
                                    <p class="text-dark m-0">Created By</p>
                                    <div class="d-flex align-items-center justify-content-center gap-3 h-100 px-4">
                                        <div class="rounded-circle bg-white overflow-hidden mb-2 shadow-sm" style="width: 2.8rem; height: 2.8rem;">
                                            <img src="" alt="Profile" class="w-100 h-100 object-fit-cover bg-primary">
                                        </div>
                                        <div class="me-auto">
                                            <h3 class="h6 text-dark fw-semibold mb-0">Dr. Hafiz bin Ramli</h3>
                                            <div class="badge rounded-pill px-3 py-1 mb-2 fw-normal bg-primary-subtle text-primary" style="font-size: 0.7rem;">
                                                Staff
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <hr class="mt-2 mb-0">
                                <div class="card-body p-3">
                                    <div class="d-flex flex-grow-1">
                                        <p class="m-0 d-block">Created On</p>
                                        <p class="m-0 flex-grow-1 fw-semibold text-end">
                                            <fmt:parseDate  value="${election.created_at}" type="date" pattern="yyyy-MM-dd" var="parsedCreated" />
                                            <fmt:formatDate pattern="EEEE, MMM dd, yyyy" value="${parsedCreated}"/>
                                        </p>
                                    </div>
                                    <div class="d-flex flex-grow-1">
                                        <p class="m-0 d-block">Started On</p>
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
                        <c:choose>
                            <c:when test="${hasVoted == false}">
                                <div class="col-12">
                                    <div class="card border-0 shadow-sm" style="background-color: #f0f2ff;">
                                        <div class="card-body p-4">
                                            <p class="text-uppercase text-dark fw-semibold small mb-2">
                                                VOTES SELECTED
                                            </p>
                                            
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <div class="d-flex align-items-baseline">
                                                    <span class="vote-current display-4 fw-bold text-dark me-2">0</span>
                                                    <span class="fs-3 text-muted">/${election.max_votes}</span>
                                                </div>
                                            </div>
                                            
                                            <p class="text-secondary small mb-0">
                                                You must select ${election.max_votes} candidates before you can submit your vote.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <form method="POST" class="col-12" onclick="if(confirm('WARNING: Are you sure you want to recast your vote? This action cannot be undone.')) this.submit();">
                                    <input type="hidden" name="election_id" value="${election.election_id}">
                                    <input type="hidden" name="student_id" value="${sessionScope.loggedUser.stud_id}" />
                                    <input type="hidden" name="action" value="delete_vote_election">

                                    <div role="button" id="recast_election_btn" class="card border-0 shadow-sm h-100 bg-warning py-4 card-anim" style="border-radius: 1rem;">
                                        <div class="card-body px-3 py-2">
                                            <div class="d-flex align-items-center justify-content-center gap-4 h-100 px-4 text-white">
                                                <svg width="30" height="30" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <g clip-path="url(#clip0_638_1136)">
                                                        <path d="M23.453 3.58398e-07H21.2306C21.1545 -8.56237e-05 21.0791 0.0153 21.009 0.0452243C20.939 0.0751486 20.8757 0.118988 20.8231 0.174084C20.7705 0.229181 20.7297 0.294386 20.703 0.365746C20.6764 0.437105 20.6645 0.513133 20.6681 0.589219L20.8556 4.46859C19.7655 3.18398 18.4085 2.1523 16.8792 1.44535C15.3498 0.7384 13.6848 0.373145 12 0.375C5.59407 0.375 0.370316 5.60297 0.375003 12.0089C0.379691 18.4252 5.58282 23.625 12 23.625C14.8786 23.6291 17.6556 22.5611 19.7897 20.6292C19.8467 20.5782 19.8927 20.5161 19.9249 20.4467C19.9571 20.3773 19.9748 20.302 19.9769 20.2255C19.979 20.1491 19.9654 20.073 19.9371 20.0019C19.9088 19.9308 19.8663 19.8663 19.8122 19.8122L18.2184 18.2184C18.1176 18.1176 17.9822 18.0588 17.8396 18.0541C17.6971 18.0493 17.558 18.0988 17.4506 18.1927C16.1913 19.3006 14.6242 19.9984 12.9582 20.193C11.2922 20.3876 9.60644 20.0697 8.12569 19.2818C6.64495 18.4939 5.43954 17.2733 4.67017 15.7828C3.90081 14.2924 3.60403 12.6028 3.81941 10.9393C4.03479 9.27589 4.75209 7.71761 5.87569 6.47223C6.99929 5.22685 8.4758 4.35355 10.1084 3.96873C11.741 3.58392 13.4521 3.70588 15.0136 4.31836C16.5751 4.93083 17.9128 6.00473 18.8484 7.39688L14.0892 7.16859C14.0131 7.16498 13.9371 7.17685 13.8657 7.20349C13.7944 7.23014 13.7292 7.271 13.6741 7.32359C13.619 7.37619 13.5752 7.43943 13.5452 7.50948C13.5153 7.57953 13.4999 7.65492 13.5 7.73109V9.95344C13.5 10.1026 13.5593 10.2457 13.6648 10.3512C13.7702 10.4567 13.9133 10.5159 14.0625 10.5159H23.453C23.6022 10.5159 23.7452 10.4567 23.8507 10.3512C23.9562 10.2457 24.0155 10.1026 24.0155 9.95344V0.5625C24.0155 0.413316 23.9562 0.270242 23.8507 0.164753C23.7452 0.0592636 23.6022 3.58398e-07 23.453 3.58398e-07Z" fill="white"/>
                                                    </g>
                                                    <defs>
                                                        <clipPath id="clip0_638_1136">
                                                            <rect width="24" height="24" fill="white"/>
                                                        </clipPath>
                                                    </defs>
                                                </svg>

                                                <div class="me-auto">
                                                    <h3 class="h6 fw-semibold mb-0">Withdraw Vote</h3>
                                                    <p class="small opacity-75 mb-0">Recast your vote</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </c:otherwise>
                        </c:choose>
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
            $(document).ready(function () {
                const maxVotes = ${election.max_votes}; 
                const HAS_VOTED = ${hasVoted ? 'true' : 'false'};
                let selectedCount = 0;

                if (HAS_VOTED) {
                    const $checkboxes = $('.candidate-card input[type="checkbox"]');
                    $checkboxes.prop('disabled', true);
                    $('button[type="submit"]').prop('disabled', true);
                } else {
                    $('.candidate-card input[type="checkbox"]').on('change', function () {
                        const $checkboxes = $('.candidate-card input[type="checkbox"]');
                        selectedCount = $checkboxes.filter(':checked').length;
                        
                        $('.vote-current').text(selectedCount);
                        $('.candidate-card').removeClass('border-primary')
                                            .addClass('border-secondary-muted');
                        $checkboxes.filter(':checked').each(function () {
                            $(this).closest('.candidate-card')
                                .removeClass('border-secondary-muted')
                                .addClass('border-primary');
                        });

                        $('.candidate-card input[type="checkbox"]:checked').each(function() {
                            $(this).closest('.candidate-card')
                                .removeClass('border-secondary-muted')
                                .addClass('border-primary');
                        });

                        if (selectedCount >= maxVotes) {
                            $checkboxes.not(':checked').prop('disabled', true);
                        } else {
                            $checkboxes.prop('disabled', false);
                        }

                        $('button[type="submit"]').prop('disabled', selectedCount < maxVotes);
                    });

                    function validateVote() {
                        if (selectedCount < maxVotes) {
                            alert(`Please select exactly ${maxVotes} candidate(s) before submitting.`);
                            return false;
                        }
                        
                        const confirmed = confirm(`Are you sure you want to submit your vote for ${selectedCount} candidate(s)? This action cannot be undone.`);
                        return confirmed;
                    }
                    $('form[method="post"]').on('submit', function(e) {
                        if (!validateVote()) {
                            e.preventDefault();
                            return false;
                        }
                    });
                    $('button[type="submit"]').prop('disabled', true);
                }

                $('#candidateModal').on('show.bs.modal', function(event) {
                    var trigger = $(event.relatedTarget);
                    var candidateId   = trigger.data('candidateId');
                    var fullName      = trigger.data('candidateName');
                    var slogan        = trigger.data('candidateSlogan');
                    var studNumber = trigger.data('candidateStudNumber');
                    var manifesto     = trigger.data('candidateManifesto');
                    var photo         = trigger.data('candidatePhotoUrl');
                    var banner        = trigger.data('candidateBannerUrl');
                    var status        = trigger.data('candidateStatus');

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
