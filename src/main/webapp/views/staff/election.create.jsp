<%-- 
    Document   : election.create
    Created on : Jan 10, 2026, 9:56:32 PM
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
                    <h1 class="h4 fw-bold mb-0">Create Election</h1>

                    <a href="${pageContext.request.contextPath}/elections" type="button" class="btn rounded-pill px-4 bg-white border border-1 card-anim" style="width: fit-content;">
                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M4.16675 9.99992H15.8334" stroke="#121026" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M4.16675 10L9.16675 15" stroke="#121026" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M4.16675 10L9.16675 5" stroke="#121026" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        Return
                    </a>

                    <form method="POST" id="create_form">
                        <input type="hidden" name="created_by" value="${sessionScope.loggedUser.staff_id}"/>
                        
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
                                                <sql:param value="${sessionScope.loggedUser.campus_id}"/>
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
                                                        <input class="form-check-input" type="checkbox" id="facultySwitch" name="is_faculty_specific">
                                                    </div>
                                                </div>
                                                <sql:query var="facultyList" dataSource="${myDatasource}">
                                                    SELECT * FROM FACULTY WHERE CAMPUS_ID = ?::integer
                                                    <sql:param value="${sessionScope.loggedUser.campus_id}"/>
                                                </sql:query>
                                                <select name="faculty_id" class="form-control" id="facultySelect" disabled required>
                                                    <option value="">Select Faculty (Disabled)</option>
                                                    <c:forEach var="faculty" items="${facultyList.rows}">
                                                        <option value="${faculty.faculty_id}">${faculty.faculty_code} - ${faculty.faculty_name}</option> 
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="col-md-12">
                                                <label class="mb-1"><small>Election Title</small></label>
                                                <input type="text" name="title" class="form-control" placeholder="e.g. SRC Election 2026" required/>
                                            </div>

                                            <div class="col-12">
                                                <label class="mb-1"><small>Election Description</small></label>
                                                <textarea id="description" name="description" class="form-control" rows="3" maxlength="5000" required></textarea>
                                                <small class="text-secondary"><span id="charCount">0</span> / 5000 </small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="accordion-item border-1 shadow-sm rounded-4 overflow-hidden">
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
                                                <input type="text" name="session" class="form-control" placeholder="2025/2026" required/>
                                            </div>
                                            
                                            <div class="col-md-6">
                                                <label class="mb-1"><small>Max Votes per Voter</small></label>
                                                <input type="number" name="max_votes" class="form-control" value="1" min="1" required/>
                                            </div>

                                            <div class="col-md-6">
                                                <label class="mb-1"><small>Start Date & Time</small></label>
                                                <div class="input-group" id="startDatePicker" data-td-target-input="nearest" data-td-target-toggle="nearest">
                                                    <input id="startDateInput" name="start_date" type="text" class="form-control" data-td-target="#startDatePicker" required/>
                                                    <span class="input-group-text" data-td-target="#startDatePicker" data-td-toggle="datetimepicker">
                                                        <i class="fa fa-calendar text-dark"></i>
                                                    </span>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <label class="mb-1"><small>End Date & Time</small></label>
                                                <div class="input-group" id="endDatePicker" data-td-target-input="nearest" data-td-target-toggle="nearest">
                                                    <input id="endDateInput" name="end_date" type="text" class="form-control" data-td-target="#endDatePicker" required/>
                                                    <span class="input-group-text" data-td-target="#endDatePicker" data-td-toggle="datetimepicker">
                                                        <i class="fa fa-calendar text-dark"></i>
                                                    </span>
                                                </div>
                                            </div>

                                            <div class="col-12 mt-4">
                                                <div class="card bg-light border-1">
                                                    <div class="card-body py-2 px-3">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="checkbox" name="candidacy_open" id="openCandidacy" value="true">
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
                        </div>
                    </form>

                </div>

                <div class="d-none d-xl-block p-4 p-xl-5" style="width: 300px; min-width: 30%; background-color: #F3F9FE;">
                    <h3 class="h6 fw-bold text-dark text-uppercase">INFORMATION</h3>
                    <div class="row g-3 mt-2">
                        <div class="col-12">
                            <div class="card border-0 shadow-sm h-100 bg-white border border-1" style="border-radius: 1rem;">
                                <div class="card-body p-3">
                                    <p class="text-dark m-0">Created By</p>
                                    <div class="d-flex align-items-center justify-content-center gap-3 h-100 px-4">
                                        <div class="rounded-circle bg-white overflow-hidden mb-2 shadow-sm" style="width: 2.8rem; height: 2.8rem;">
                                            <img src="" alt="Profile" class="w-100 h-100 object-fit-cover bg-primary">
                                        </div>
                                        <div class="me-auto">
                                            <h3 class="h6 text-dark fw-semibold mb-0">${sessionScope.loggedUser.full_name}</h3>
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
                                            <jsp:useBean id="now" class="java.util.Date" scope="page" />
                                            <fmt:formatDate value="${now}" pattern="dd MMMM yyyy" />
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-12">
                            <div role="button" id="create_btn" class="card border-0 shadow-sm h-100 bg-primary py-4 card-anim" style="border-radius: 1rem;">
                                <div class="card-body px-3 py-2">
                                    <div class="d-flex align-items-center justify-content-center gap-4 h-100 px-4 text-white">
                                        <svg width="30" height="30" viewBox="0 0 800 800" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M690.333 109.667C680.736 100.147 669.254 92.7391 656.626 87.9172C643.997 83.0953 630.5 80.9663 617 81.6667C589.531 83.1902 563.671 95.1074 544.667 115L315.333 343C313.809 344.675 312.57 346.59 311.667 348.667C310.352 350.547 309.235 352.557 308.333 354.667L266.667 490.667C265.181 495.744 264.925 501.103 265.921 506.299C266.916 511.495 269.134 516.379 272.391 520.548C275.648 524.718 279.851 528.051 284.652 530.275C289.453 532.498 294.714 533.546 300 533.333C303.092 533.82 306.241 533.82 309.333 533.333L442.667 494.333L448.667 491C450.744 490.097 452.658 488.858 454.333 487.333L683.333 258C703.226 238.996 715.143 213.136 716.667 185.667C717.968 171.852 716.291 157.919 711.749 144.809C707.206 131.698 699.903 119.714 690.333 109.667Z" fill="currentColor"/>
                                            <path d="M666.667 733.333H133.333C115.652 733.333 98.6954 726.31 86.193 713.807C73.6905 701.305 66.6667 684.348 66.6667 666.667V133.333C66.6667 115.652 73.6905 98.6954 86.193 86.193C98.6954 73.6905 115.652 66.6667 133.333 66.6667H400C408.841 66.6667 417.319 70.1786 423.57 76.4299C429.821 82.6811 433.333 91.1595 433.333 100C433.333 108.841 429.821 117.319 423.57 123.57C417.319 129.822 408.841 133.333 400 133.333H133.333V666.667H666.667V400C666.667 391.16 670.179 382.681 676.43 376.43C682.681 370.179 691.16 366.667 700 366.667C708.841 366.667 717.319 370.179 723.57 376.43C729.822 382.681 733.333 391.16 733.333 400V666.667C733.333 684.348 726.31 701.305 713.807 713.807C701.305 726.31 684.348 733.333 666.667 733.333Z" fill="currentColor"/>
                                        </svg>
                                        <div class="me-auto">
                                            <h3 class="h6 fw-semibold mb-0">Create Election</h3>
                                            <p class="small opacity-75 mb-0">New Election Entry</p>
                                        </div>
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

        <%-- Javascripts  --%>
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>

        <script>
            $(document).ready(function () {
                const pickerOptions = {
                    display: {
                        components: {
                            calendar: true,
                            date: true,
                            seconds: true,
                            useTwentyfourHour: true
                        },
                        theme: 'light'
                    },
                    localization: {
                        format: 'yyyy-MM-dd HH:mm:ss',
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
                    
                    // Toggle disabled and required status
                    $select.prop('disabled', !isChecked)
                        .prop('required', isChecked);
                    
                    if (isChecked) {
                        $select.find('option:first').text('Select Faculty');
                    } else {
                        $select.val('').find('option:first').text('Select Faculty (Disabled)');
                    }
                });

                $('#create_btn').on('click', function() {
                    const form = $('#create_form')[0]; 
                    if (form.reportValidity()) { 
                        form.submit(); 
                    }
                })
            });
        </script>
    </body>
</html>