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

    <sql:query dataSource="${myDatasource}" var="locationInfo">
        SELECT CAMPUS_NAME, FACULTY_NAME
        FROM ELECTIONS E
        LEFT JOIN CAMPUS C ON E.CAMPUS_ID = C.CAMPUS_ID
        LEFT JOIN FACULTY F ON E.FACULTY_ID = F.FACULTY_ID
        WHERE E.ELECTION_ID = ?
        <sql:param value="${election.election_id}" />
    </sql:query>
    <c:set var="loc" value="${locationInfo.rows[0]}" />
    
    <body style="background-color: #121026">
        <div class="d-flex vh-100 overflow-hidden">

            <div class="h-100">
                <%@ include file="/WEB-INF/jspf/nav.jspf" %>
            </div>

            <main class="d-flex flex-grow-1 overflow-hidden">
                
                <div class="flex-grow-1 rounded-start-5 p-4 p-xl-5 overflow-auto no-scrollbar d-flex flex-column gap-4" style="background-color: #F3F9FE;">
                    <h1 class="h4 fw-bold mb-0">Upcoming Election</h1>

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

                    <c:choose>
                        <c:when test="${election.candidacy_open}">
                            <button type="button" class="mx-auto px-5 btn rounded-pill bg-white border border-1 card-anim d-flex flex-row gap-2 justify-content-center align-items-center text-dark py-2" data-bs-toggle="modal" data-bs-target="#registerCandidateModal">
                                <svg width="20" height="20" viewBox="0 0 800 800" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <g clip-path="url(#clip0_525_1117)">
                                    <path d="M600 300H133.333V266.667H600V300ZM433.333 400H133.333V433.333H433.333V400ZM700 133.333V433.333H666.667V166.667H66.6668V600H366.667V633.333H33.3335V133.333H700ZM769 521.233L745.433 497.667L550 693.1L454.567 597.667L431 621.233L550 740.233L769 521.233Z" fill="currentColor"/>
                                    </g>
                                    <defs>
                                    <clipPath id="clip0_525_1117">
                                    <rect width="800" height="800" fill="white"/>
                                    </clipPath>
                                    </defs>
                                </svg>
                                APPLY AS CANDIDATE
                            </button>
                        </c:when>
                        <c:otherwise>
                            <div class="col-12">
                                <div class="border-0">
                                    <div class="p-5 text-center">
                                        <svg width="100" height="100" viewBox="0 0 800 634" fill="currentColor" class="mb-3 text-dark" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M306.137 504.48H232.297L164.847 633.758H800L732.55 504.48H665.43L680.239 549.447H635.241L569.547 206.577C569.547 206.577 561.675 208.684 549.897 211.703L549.084 207.619C547.634 200.559 544.956 194.148 541.772 188.045C538.567 181.952 534.833 176.2 530.969 170.842L529.85 169.294L528.445 168.075C519.575 160.236 503.525 147.392 476.255 129.641L476.32 129.684C447.767 111.02 415.48 101.02 387.342 100.35C326.677 99.0984 259.644 97.725 241.717 97.3641L224.755 86.4516L234.778 71.6625L131.198 0L0 195.28L102.383 266.923L116.127 246.656L151.148 270.314L201.614 345.328C209.069 356.394 219.223 365.439 231.158 371.511L231.278 371.577C231.3 371.577 240.269 376.056 252.872 382.423C265.453 388.791 281.647 397.047 295.928 404.545L295.95 404.556C307.456 410.572 320.52 415.797 334.33 420.409L334.505 420.464L343.287 423.187L367.614 549.447H321.1L306.137 504.48ZM344.933 388.397C332.384 384.203 320.858 379.538 311.581 374.675H311.603C282.819 359.581 247.095 341.784 246.381 341.422C239.684 338.008 233.813 332.794 229.597 326.513L175.475 246.042L135.053 218.739L205.819 114.381L231.508 130.894L236.272 130.981C236.316 130.992 256.186 131.398 284.928 131.981C313.68 132.573 351.28 133.342 386.652 134.078C407.103 134.397 434.769 142.619 457.789 157.856L458.492 158.317L457.856 157.9C482.381 173.884 496.763 185.258 504.622 192.064C505.589 193.425 506.511 194.786 507.389 196.148L460.864 200.045L403.669 220.75L401.484 222.506C383.117 237.25 372.294 259.381 371.92 282.875V283.939C371.911 307.136 382.086 329.158 399.772 344.177L403.494 347.327L403.955 347.392C405.339 348.513 407.27 350.092 410.081 352.453C416.372 357.733 426.723 366.559 443.586 381.205C446.683 383.894 448.439 386.32 449.427 388.33C450.425 390.35 450.733 391.964 450.745 393.544C450.767 396.838 449.055 400.922 444.706 404.642C440.425 408.288 433.905 410.977 426.395 410.966C423.366 410.966 420.181 410.548 416.844 409.583L416.066 409.364L416.911 409.605C403.869 405.784 390.125 402.108 376.688 398.222L344.933 388.397Z" fill="currentColor"/>
                                        </svg>
                                        <h3 class="h5 text-dark mb-0">The Election Starts Soon!</h3>
                                        <p class="text-dark opacity-75 mb-0">Raise your voice through your vote.</p>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
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
                                            <p class="small text-white opacity-75 mb-0">Registered Candidacy</p>
                                        </div>
                                        <div class="display-4 fw-bold text-white">${counts.upcoming_count != null ? counts.upcoming_count : 0}</div>
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
                                            <fmt:parseDate  value="${election.created_at}"  type="date" pattern="yyyy-MM-dd" var="parsedCreated" />
                                            <fmt:formatDate pattern="EEEE, MMM dd, yyyy" value="${parsedCreated}"/>
                                        </p>
                                    </div>
                                    <div class="d-flex flex-grow-1">
                                        <p class="m-0 d-block">Starting On</p>
                                        <p class="m-0 flex-grow-1 fw-semibold text-end">
                                            <fmt:parseDate  value="${election.start_date}"  type="date" pattern="yyyy-MM-dd" var="parsedStart" />
                                            <fmt:formatDate pattern="EEEE, MMM dd, yyyy" value="${parsedStart}"/>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </main>

            <form method="POST" class="modal modal-lg fade" id="registerCandidateModal" tabindex="-1" aria-labelledby="registerCandidate" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="registerCandidate">Register as Candidate</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row px-2">
                                <div class="col">
                                    <p class="fw-semibold">STUDENT INFORMATION</p>
                                    <div class="row g-3">
                                        <div class="col-md-9">
                                            <label class="mb-1"><small>Full Name</small></label>
                                            <input type="text" class="form-control" value="${sessionScope.loggedUser.full_name}" disabled/>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="mb-1"><small>Student No</small></label>
                                            <input type="text" class="form-control" value="${sessionScope.loggedUser.stud_number}" disabled/>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="mb-1"><small>Campus</small></label>
                                            <input type="text" class="form-control" value="${loc.CAMPUS_NAME}" disabled/>
                                        </div>
                                        <c:if test="${not empty loc.FACULTY_NAME}">
                                        <div class="col-md-6">
                                            <label class="mb-1"><small>Faculty</small></label>
                                            <input type="text" class="form-control" value="${loc.FACULTY_NAME}" disabled/>
                                        </div>
                                        </c:if>
                                    <div>
                                </div>
                                <div class="col">
                                    <p class="fw-semibold">CANDIDATE DETAILS</p>
                                    <div class="row g-3">
                                        <div class="col-12">
                                            <label class="mb-1"><small>Manifesto</small></label>
                                            <textarea id="manifesto" class="form-control bg-white" rows="2" maxlength="1000"></textarea>
                                            <small class="text-secondary"><span id="charCount">0</span> / 1000 </small>
                                        </div>
                                        <div class="col-12">
                                            <label class="mb-1"><small>Slogan</small></label>
                                            <input type="text" class="form-control bg-white"/>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="mb-1"><small>Campaign Profile Photo</small></label>
                                            <input type="file" class="form-control bg-white"/>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="mb-1"><small>Campaign Banner</small></label>
                                            <input type="file" class="form-control bg-white"/>
                                        </div>
                                    <div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary">Submit Registration</button>
                        </div>
                    </div>
                </div>
            </form>

        </div>

        <%-- Javascripts  --%>
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>
        <script>
            $(document).ready(function () {
                const $textarea = $('#manifesto');
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
            });
        </script>

    </body>
</html>
