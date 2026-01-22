<%-- 
    Document   : report
    Created on : Jan 12, 2026
    Author     : ASUS
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Report" />
    
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/datatables-buttons@1.2.4/css/buttons.dataTables.min.css">
    </head>
    
    <body style="background-color: #121026">
        <div class="d-flex vh-100 overflow-hidden">

            <div class="h-100">
                <%@ include file="/WEB-INF/jspf/nav_staff.jspf" %>
            </div>

            <main class="d-flex flex-grow-1 overflow-hidden">
                
                <div class="flex-grow-1 rounded-start-5 p-4 p-xl-5 overflow-auto no-scrollbar d-flex flex-column gap-4" style="background-color: #F3F9FE;">
                    <div class="d-flex align-items-center justify-content-between">
                        <h1 class="h4 fw-bold mb-0">Reports</h1>
                    </div>

                    <!-- Filter Section -->
                    <div class="card border-0 shadow-sm rounded-4" style="background-color: white;">
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-3">Filter Options</h5>
                            <div class="row g-3">
                                <div class="col-md-3">
                                    <label class="form-label small fw-semibold">Session</label>
                                    <select class="form-select form-select-sm" id="filterSession">
                                        <option value="">All Sessions</option>
                                        <sql:query dataSource="${myDatasource}" var="sessions">
                                            SELECT DISTINCT SESSION FROM ELECTIONS 
                                            WHERE CAMPUS_ID = ? AND SESSION IS NOT NULL
                                            ORDER BY SESSION DESC
                                            <sql:param value="${loggedUser.campus_id}" />
                                        </sql:query>
                                        <c:forEach var="session" items="${sessions.rows}">
                                            <option value="${session.session}">${session.session}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-3">
                                    <label class="form-label small fw-semibold">Faculty</label>
                                    <select class="form-select form-select-sm" id="filterFaculty">
                                        <option value="">All Faculties</option>
                                        <option value="campus">Campus-wide</option>
                                        <sql:query dataSource="${myDatasource}" var="faculties">
                                            SELECT DISTINCT f.FACULTY_ID, f.FACULTY_CODE, f.FACULTY_NAME 
                                            FROM FACULTY f
                                            WHERE f.CAMPUS_ID = ?
                                            ORDER BY f.FACULTY_NAME ASC
                                            <sql:param value="${loggedUser.campus_id}" />
                                        </sql:query>
                                        <c:forEach var="faculty" items="${faculties.rows}">
                                            <option value="${faculty.faculty_id}">${faculty.faculty_code} - ${faculty.faculty_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-3">
                                    <label class="form-label small fw-semibold">Election Status</label>
                                    <select class="form-select form-select-sm" id="filterStatus">
                                        <option value="">All Status</option>
                                        <option value="upcoming">Upcoming</option>
                                        <option value="active">Active</option>
                                        <option value="closed">Closed</option>
                                        <option value="cancelled">Cancelled</option>
                                    </select>
                                </div>

                                <div class="col-md-3">
                                    <label class="form-label small fw-semibold">Date Range</label>
                                    <select class="form-select form-select-sm" id="filterDateRange">
                                        <option value="">All Time</option>
                                        <option value="today">Today</option>
                                        <option value="week">Last 7 Days</option>
                                        <option value="month">Last 30 Days</option>
                                        <option value="year">Last Year</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row g-3 mt-2">
                                <div class="col-12">
                                    <button class="btn btn-sm btn-primary rounded-pill px-4" id="filterBtn">Apply Filters</button>
                                    <button class="btn btn-sm btn-secondary rounded-pill px-4" id="clearFilterBtn">Clear Filters</button>
                                    <button onclick="downloadAsPDF()" class="btn btn-sm rounded-pill px-4 btn-outline-primary">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="me-1">
                                            <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
                                            <polyline points="7 10 12 15 17 10"/>
                                            <line x1="12" y1="15" x2="12" y2="3"/>
                                        </svg>
                                        Download as PDF
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Data Table -->
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
                            </div>
                        </div>

                        <!-- Table -->
                        <table id="reportTable" class="display table-responsive" style="width:100%">
                            <thead>
                                <tr>
                                    <th style="width: 150px;">Election Title</th>
                                    <th>Session</th>
                                    <th>Type</th>
                                    <th>Faculty</th>
                                    <th>Status</th>
                                    <th>Start Date</th>
                                    <th>End Date</th>
                                    <th>Total Candidates</th>
                                    <th>Approved Candidates</th>
                                    <th>Total Votes</th>
                                    <th>Participation %</th>
                                    <th>Created By</th>
                                    <th>Created Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <sql:query dataSource="${myDatasource}" var="allElections">
                                    SELECT e.ELECTION_ID, e.TITLE, e.SESSION, e.ELECTION_TYPE, 
                                            e.STATUS, e.START_DATE, e.END_DATE, e.CREATED_AT, e.CREATED_BY,
                                            e.CAMPUS_ID, e.FACULTY_ID,
                                            COUNT(DISTINCT c.CANDIDATE_ID) as total_candidates,
                                            COUNT(DISTINCT CASE WHEN c.STATUS = 'approved' THEN c.CANDIDATE_ID END) as approved_candidates,
                                            COUNT(DISTINCT v.STUDENT_ID) as total_votes,
                                            s.FULL_NAME as creator_name,
                                            f.FACULTY_CODE, f.FACULTY_NAME
                                    FROM ELECTIONS e
                                    LEFT JOIN CANDIDATES c ON e.ELECTION_ID = c.ELECTION_ID
                                    LEFT JOIN VOTES v ON c.CANDIDATE_ID = v.CANDIDATE_ID
                                    LEFT JOIN STAFFS s ON e.CREATED_BY = s.STAFF_ID
                                    LEFT JOIN FACULTY f ON e.FACULTY_ID = f.FACULTY_ID
                                    WHERE e.CAMPUS_ID = ?
                                    GROUP BY e.ELECTION_ID, e.TITLE, e.SESSION, e.ELECTION_TYPE, 
                                                e.STATUS, e.START_DATE, e.END_DATE, e.CREATED_AT, e.CREATED_BY,
                                                e.CAMPUS_ID, e.FACULTY_ID, s.FULL_NAME, f.FACULTY_CODE, f.FACULTY_NAME
                                    ORDER BY e.CREATED_AT DESC
                                    <sql:param value="${loggedUser.campus_id}" />
                                </sql:query>

                                <c:forEach var="election" items="${allElections.rows}">
                                    <sql:query dataSource="${myDatasource}" var="eligibleVoters">
                                        <c:choose>
                                            <c:when test="${election.election_type == 'campus'}">
                                                SELECT COUNT(STUD_ID) as student_count
                                                FROM STUDENTS
                                                WHERE CAMPUS_ID = ? AND IS_ACTIVE = true
                                                <sql:param value="${election.campus_id}" />
                                            </c:when>
                                            <c:otherwise>
                                                SELECT COUNT(STUD_ID) as student_count
                                                FROM STUDENTS
                                                WHERE FACULTY_ID = ? AND IS_ACTIVE = true
                                                <sql:param value="${election.faculty_id}" />
                                            </c:otherwise>
                                        </c:choose>
                                    </sql:query>
                                    <c:set var="studentCount" value="${eligibleVoters.rows[0].student_count}" />
                                    <c:set var="participationPercent" value="${studentCount > 0 ? (election.total_votes * 100) / studentCount : 0}" />

                                    <tr class="election-row" 
                                        data-session="${election.session}" 
                                        data-faculty="${election.election_type == 'campus' ? 'campus' : election.faculty_id}"
                                        data-status="${election.status}"
                                        data-created="${election.created_at.time}">
                                        <td class="fw-semibold">${election.title}</td>
                                        <td>${election.session != null ? election.session : '-'}</td>
                                        <td>
                                            <c:if test="${election.election_type == 'campus'}">
                                                <span class="badge bg-secondary text-white">Campus</span>
                                            </c:if>
                                            <c:if test="${election.election_type == 'faculty'}">
                                                <span class="badge bg-primary">Faculty</span>
                                            </c:if>
                                        </td>
                                        <td>${election.election_type == 'campus' ? 'All' : (election.faculty_code != null ? election.faculty_code : '-')}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${election.status == 'upcoming'}">
                                                    <span class="badge rounded-2" style="background-color: #4c3d99; color: white; width: fit-content; ">
                                                        Upcoming
                                                    </span>
                                                </c:when>
                                                <c:when test="${election.status == 'active'}">
                                                    <span class="badge rounded-2" style="background-color: #7367F0; color: white; width: fit-content; ">
                                                        Active
                                                    </span>
                                                </c:when>
                                                <c:when test="${election.status == 'closed'}">
                                                    <span class="badge rounded-2" style="background-color: #d4d4f7; color: #5b4fc9; width: fit-content; ">
                                                        Closed
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge rounded-2" style="background-color: #9CA3AF; color: white; width: fit-content; ">
                                                        ${election.status}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>  
                                        </td>
                                        <td><fmt:formatDate value="${election.start_date}" pattern="dd MMM yyyy"/></td>
                                        <td><fmt:formatDate value="${election.end_date}" pattern="dd MMM yyyy"/></td>
                                        <td class="text-center">${election.total_candidates}</td>
                                        <td class="text-center">${election.approved_candidates}</td>
                                        <td class="text-center">${election.total_votes}</td>
                                        <td class="text-center"><fmt:formatNumber value="${participationPercent}" maxFractionDigits="1"/>%</td>
                                        <td>${election.creator_name != null ? election.creator_name : '-'}</td>
                                        <td><fmt:formatDate value="${election.created_at}" pattern="dd MMM yyyy"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                </div>

            </main>
        </div>

        <%-- Javascripts  --%>
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>
        
        <script src="https://cdn.jsdelivr.net/npm/datatables-buttons@1.2.4/js/dataTables.buttons.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/datatables-buttons@1.2.4/js/buttons.html5.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/datatables-buttons@1.2.4/js/buttons.print.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>

        <script>
            $(document).ready(function() {
                // Initialize DataTable with export buttons
                var table = $('#reportTable').DataTable({
                    paging: true,
                    pageLength: 10,
                    lengthMenu: [5, 25, 50, 100],
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
                    buttons: [
                        {
                            extend: 'pdf',
                            text: '<i class="fa fa-file-pdf"></i> PDF',
                            className: 'btn btn-sm btn-danger rounded-pill px-3 me-2',
                            title: 'Election Report - ' + new Date().toLocaleDateString(),
                            exportOptions: {
                                columns: ':visible',
                                stripHtml: false
                            }
                        },
                        {
                            extend: 'excel',
                            text: '<i class="fa fa-file-excel"></i> Excel',
                            className: 'btn btn-sm btn-success rounded-pill px-3 me-2',
                            title: 'Election Report - ' + new Date().toLocaleDateString(),
                            exportOptions: {
                                columns: ':visible'
                            }
                        },
                        {
                            extend: 'print',
                            text: '<i class="fa fa-print"></i> Print',
                            className: 'btn btn-sm btn-primary rounded-pill px-3',
                            exportOptions: {
                                columns: ':visible'
                            }
                        }
                    ],
                    scrollX: true,
                    pageLength: 10,
                    columnDefs: [
                        { targets: '_all', className: 'dt-left' }
                    ],
                    initComplete: function() {
                        // Move buttons to a custom container
                        $('.dt-buttons').addClass('mb-3').find('button').each(function() {
                            $(this).css('margin', '2px');
                        });
                    }
                });

                // Filter function
                function applyFilters() {
                    const session = $('#filterSession').val();
                    const faculty = $('#filterFaculty').val();
                    const status = $('#filterStatus').val();
                    const dateRange = $('#filterDateRange').val();
                    const now = new Date().getTime();
                    
                    table.rows().every(function() {
                        var row = $(this.node());
                        var sessionVal = row.data('session');
                        var facultyVal = row.data('faculty');
                        var statusVal = row.data('status');
                        var createdVal = parseInt(row.data('created'));
                        
                        var showRow = true;

                        // Session filter
                        if (session && sessionVal !== session) {
                            showRow = false;
                        }

                        // Faculty filter
                        if (showRow && faculty && facultyVal !== faculty) {
                            showRow = false;
                        }

                        // Status filter
                        if (showRow && status && statusVal !== status) {
                            showRow = false;
                        }

                        // Date range filter
                        if (showRow && dateRange) {
                            const daysDiff = Math.floor((now - createdVal) / (1000 * 60 * 60 * 24));
                            switch(dateRange) {
                                case 'today':
                                    if (daysDiff > 0) showRow = false;
                                    break;
                                case 'week':
                                    if (daysDiff > 7) showRow = false;
                                    break;
                                case 'month':
                                    if (daysDiff > 30) showRow = false;
                                    break;
                                case 'year':
                                    if (daysDiff > 365) showRow = false;
                                    break;
                            }
                        }

                        row.css('display', showRow ? '' : 'none');
                    });

                    table.draw(false);
                }

                // Filter button click
                $('#filterBtn').on('click', function() {
                    applyFilters();
                });

                // Clear filters
                $('#clearFilterBtn').on('click', function() {
                    $('#filterSession').val('');
                    $('#filterFaculty').val('');
                    $('#filterStatus').val('');
                    $('#filterDateRange').val('');
                    table.rows().nodes().to$().css('display', '');
                    table.draw(false);
                });

                // Allow Enter key to apply filters
                $(document).on('keypress', function(e) {
                    if (e.which === 13) {
                        applyFilters();
                    }
                });

            });
            
            async function downloadAsPDF() {
                const { jsPDF } = window.jspdf;
                const element = document.querySelector('#reportTable');

                const canvas = await html2canvas(element, {
                    scale: 2,               // higher = sharper text (but bigger file)
                    useCORS: true,
                    logging: false,
                    backgroundColor: '#ffffff'   // avoid transparent → white edges
                });

                const imgData = canvas.toDataURL('image/png');

                const pdf = new jsPDF({
                    orientation: 'portrait',
                    unit: 'mm',
                    format: 'a4'
                });

                // ── Key part: get real PDF page width ──
                const pdfWidth = pdf.internal.pageSize.getWidth();     // ≈ 210 mm for A4
                const pdfHeight = pdf.internal.pageSize.getHeight();   // ≈ 297 mm

                // Get original image dimensions (in pixels)
                const imgProps = pdf.getImageProperties(imgData);
                const imgWidthPx  = imgProps.width;
                const imgHeightPx = imgProps.height;

                // Scale so width fills the full page (no right margin/empty space)
                const ratio = pdfWidth / imgWidthPx;
                const finalImgWidth  = pdfWidth;
                const finalImgHeight = imgHeightPx * ratio;

                // If content is very long → add pages automatically
                let heightLeft = finalImgHeight;
                let position = 0;

                pdf.addImage(imgData, 'PNG', 0, position, finalImgWidth, finalImgHeight);

                heightLeft -= pdfHeight;

                while (heightLeft > 0) {
                    position = heightLeft - finalImgHeight;  // negative = continue from previous cut
                    pdf.addPage();
                    pdf.addImage(imgData, 'PNG', 0, position, finalImgWidth, finalImgHeight);
                    heightLeft -= pdfHeight;
                }

                const dateString = new Date().toLocaleDateString();
                pdf.save('Election-Report-'+ new Date().toLocaleDateString() + '.pdf');
            }
        </script>
    </body>
</html>