/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ecems.controller;

import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.util.Enumeration;
import java.util.List;

import com.ecems.dao.CandidateDAO;
import com.ecems.dao.ElectionDAO;
import com.ecems.model.Candidate;
import com.ecems.model.Election;
import com.ecems.util.S3Connection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@WebServlet("/elections/page/*")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 5L * 1024 * 1024,      // 5 MB
    maxRequestSize = 6L * 1024 * 1024    // 6 MB
)
public class electionPageServlet extends HttpServlet {

    private ElectionDAO electionDAO;
    private CandidateDAO candidateDAO;

    @Override
    public void init() throws ServletException {
       
    	// Initialize DAO object. Called once when servlet loads. 
    	electionDAO = new ElectionDAO();
        candidateDAO = new CandidateDAO();
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.length() < 1) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        try {
            int election_id = Integer.parseInt(pathInfo.substring(1));
            Election election = electionDAO.getElectionByID(election_id);

            if (election == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            HttpSession session = request.getSession(false);
            String role = (session != null) ? (String) session.getAttribute("role") : null;
            String status = election.getStatus();
            String view = null;

            switch (role.toLowerCase()) {
                case "staff":
                    switch (status.toLowerCase()) {
                        case "upcoming":
                            view = "/views/staff/election.modify.jsp";
                            break;
                        case "active":
                        case "closed":
                        case "cancelled":
                            view = "/views/staff/election.view.jsp";
                            break;
                    }
                    break;

                case "student":
                    switch (status.toLowerCase()) {
                        case "upcoming":
                            view = "/views/student/election.upcoming.jsp";
                            break;
                        case "active":
                            view = "/views/student/election.active.jsp";
                            break;
                        case "closed":
                            view = "/views/student/election.closed.jsp";
                            break;
                    }
                    break;
            }

            if (view != null) {
                request.setAttribute("election", election);
                request.getRequestDispatcher(view).forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Invalid election status for this role.");
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
           
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            String action = request.getParameter("action");

            switch (action) {
                case "register_candidate":
                    registerCandidate(request, response);
                    break;
                case "approve_candidate":
                    updateCandidate(request, response, "approved");
                    break;
                case "reject_candidate":
                    updateCandidate(request, response, "rejected");
                    break;
                case "update_election":
                    updateElection(request, response);
                    break;
                case "start_election":
                    startElection(request, response);
                    break;
                case "cancel_election":
                    cancelElection(request, response);
                    break;
                case "close_election":
                    closeElection(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
            }

    }

    private void registerCandidate(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String errorMsg = null;
        int election_id = Integer.parseInt(request.getParameter("election_id"));
        int stud_id = Integer.parseInt(request.getParameter("stud_id"));
        
        try {
            String manifesto = request.getParameter("manifesto");
            String slogan = request.getParameter("slogan");

            // Handle Photo Upload
            Part photoPart = request.getPart("photo");
            String photoPath = null;
            if (photoPart != null && photoPart.getSize() > 0) {
                String submittedFileName = photoPart.getSubmittedFileName();
                String contentType = photoPart.getContentType();
                long fileSize = photoPart.getSize();

                // Generate unique filename
                String extension = "";
                int dotIndex = submittedFileName.lastIndexOf('.');
                if (dotIndex > 0 && dotIndex < submittedFileName.length() - 1) {
                    extension = submittedFileName.substring(dotIndex);
                }
                String fileNameInBucket = "photo/photo_" + stud_id + "_" + election_id + "_" + System.currentTimeMillis() + extension;

                try (InputStream inputStream = photoPart.getInputStream()) {
                    S3Client s3 = S3Connection.getClient();
                    String bucketName = "ecems";

                    PutObjectRequest putRequest = PutObjectRequest.builder()
                            .bucket(bucketName)
                            .key(fileNameInBucket)
                            .contentType(contentType)
                            .build();

                    s3.putObject(putRequest, RequestBody.fromInputStream(inputStream, fileSize));
                    photoPath = S3Connection.getPublicObjectUrl(bucketName, fileNameInBucket);
                    
                    if (photoPath == null || photoPath.isEmpty()) {
                        throw new Exception("Failed to generate public URL for photo");
                    }
                    
                    System.out.println("Photo uploaded successfully: " + photoPath);

                } catch (Exception e) {
                    e.printStackTrace();
                    throw new Exception("Error uploading photo: " + e.getMessage());
                }
            } else {
                throw new Exception("Photo file is required and cannot be empty");
            }

            // Handle Banner Upload
            Part bannerPart = request.getPart("banner");
            String bannerPath = null;
            if (bannerPart != null && bannerPart.getSize() > 0) {
                String submittedFileName = bannerPart.getSubmittedFileName();
                String contentType = bannerPart.getContentType();
                long fileSize = bannerPart.getSize();

                // Generate unique filename
                String extension = "";
                int dotIndex = submittedFileName.lastIndexOf('.');
                if (dotIndex > 0 && dotIndex < submittedFileName.length() - 1) {
                    extension = submittedFileName.substring(dotIndex);
                }
                String fileNameInBucket = "banner/banner_" + stud_id + "_" + election_id + "_" + System.currentTimeMillis() + extension;

                try (InputStream inputStream = bannerPart.getInputStream()) {
                    S3Client s3 = S3Connection.getClient();
                    String bucketName = "ecems";

                    PutObjectRequest putRequest = PutObjectRequest.builder()
                            .bucket(bucketName)
                            .key(fileNameInBucket)
                            .contentType(contentType)
                            .build();

                    s3.putObject(putRequest, RequestBody.fromInputStream(inputStream, fileSize));
                    bannerPath = S3Connection.getPublicObjectUrl(bucketName, fileNameInBucket);
                    
                    if (bannerPath == null || bannerPath.isEmpty()) {
                        throw new Exception("Failed to generate public URL for banner");
                    }
                    
                    System.out.println("Banner uploaded successfully: " + bannerPath);

                } catch (Exception e) {
                    e.printStackTrace();
                    throw new Exception("Error uploading banner: " + e.getMessage());
                }
            } else {
                throw new Exception("Banner file is required and cannot be empty");
            }

            // Create Candidate Object
            Candidate candidate = new Candidate();
            candidate.setElection_id(election_id);
            candidate.setStudent_id(stud_id);
            candidate.setManifesto(manifesto);
            candidate.setSlogan(slogan);
            candidate.setPhoto_url(photoPath);
            candidate.setBanner_url(bannerPath);

            if (candidateDAO.createCandidate(candidate)) {
                response.sendRedirect(request.getContextPath() + "/elections/page/" + election_id);
                return;
            } else {
                throw new Exception("Failed to create candidate in database");
            }

        } catch (Exception e) {
            e.printStackTrace();
            errorMsg = e.getMessage();
        }

        Election election = electionDAO.getElectionByID(election_id);
        request.setAttribute("election", election);
        request.setAttribute("error", errorMsg);
        request.getRequestDispatcher("/views/student/election.upcoming.jsp").forward(request, response);
    }

    private void updateCandidate(HttpServletRequest request, HttpServletResponse response, String status)
            throws ServletException, IOException {

            int election_id = Integer.parseInt(request.getParameter("election_id"));
            int candidate_id = Integer.parseInt(request.getParameter("candidate_id"));

            if (candidateDAO.updateCandidateStatus(candidate_id, status)) {
                response.sendRedirect(request.getContextPath() + "/elections/page/" + election_id);
                return;
            }

            Election updated_election = electionDAO.getElectionByID(election_id);
            request.setAttribute("election", updated_election);
            request.setAttribute("error", "Failed to update the candidate");
            request.getRequestDispatcher("/views/staff/election.modify.jsp").forward(request, response);
    }

    // Update election only for upcoming status
    private void updateElection(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

            int election_id = Integer.parseInt(request.getParameter("election_id"));
            int campus_id = Integer.parseInt(request.getParameter("campus_id"));
            
            int max_votes = Integer.parseInt(request.getParameter("max_votes"));

            boolean isFacultySpecific = request.getParameter("is_faculty_specific") != null;
            String facultyIdStr = request.getParameter("faculty_id");
            int faculty_id;
            String election_type;
            if (isFacultySpecific && facultyIdStr != null && !facultyIdStr.isEmpty()) {
                faculty_id = Integer.parseInt(facultyIdStr);
                election_type = "faculty";
            } else {
                faculty_id = 0;
                election_type = "campus";
            }
            
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String session = request.getParameter("session");

            String startDateStr = request.getParameter("start_date");
            String endDateStr = request.getParameter("end_date");
            LocalDateTime start_date = null, end_date = null;
            if (startDateStr != null && !startDateStr.isEmpty()) {
                start_date = LocalDateTime.parse(startDateStr.replace(" ", "T"));
            }
            if (endDateStr != null && !endDateStr.isEmpty()) {
                end_date = LocalDateTime.parse(endDateStr.replace(" ", "T"));
            }
            
            String openCandidacyStr = request.getParameter("candidacy_open");
            boolean candidacy_open = (openCandidacyStr != null && openCandidacyStr.equals("true"));

            Election election = new Election();
            election.setTitle(title);
            election.setDescription(description);
            election.setSession(session);
            election.setElection_type(election_type);
            election.setStart_date(start_date);
            election.setEnd_date(end_date);
            election.setStatus("upcoming");
            election.setCampus_id(campus_id);
            election.setFaculty_id(faculty_id);
            election.setCandidacy_open(candidacy_open);
            election.setMax_votes(max_votes);
            election.setElection_id(election_id);

            if (electionDAO.updateElectionByID(election) != null) {
                response.sendRedirect(request.getContextPath() + "/elections/page/" + election_id);
                return;
            }

            Election updated_election = electionDAO.getElectionByID(election_id);
            request.setAttribute("election", updated_election);
            request.setAttribute("error", "Failed to update the election");
            request.getRequestDispatcher("/views/staff/election.modify.jsp").forward(request, response);
    }

    private void startElection(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

            int election_id = Integer.parseInt(request.getParameter("election_id"));
            String status = "active";

            List<Candidate> candidates = candidateDAO.getApprovedCandidatesByElection(election_id);

            if (candidates == null || candidates.size() < 2) {
                Election election = electionDAO.getElectionByID(election_id);
                request.setAttribute("election", election);
                request.setAttribute("error", "Cannot start election. There must be at least 2 approved candidates.");
                request.getRequestDispatcher("/views/staff/election.modify.jsp").forward(request, response);
                return;
            }

            if (electionDAO.updateElectionStatus(election_id, status) != null) {
                response.sendRedirect(request.getContextPath() + "/elections/page/" + election_id);
                return;
            }

            Election updated_election = electionDAO.getElectionByID(election_id);
            request.setAttribute("election", updated_election);
            request.setAttribute("error", "Failed to start the election due to a database error.");
            request.getRequestDispatcher("/views/staff/election.modify.jsp").forward(request, response);
    }

    private void cancelElection(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

            int election_id = Integer.parseInt(request.getParameter("election_id"));
            String status = "cancelled";

            if (electionDAO.updateElectionStatus(election_id, status) != null) {
                response.sendRedirect(request.getContextPath() + "/elections/page/" + election_id);
                return;
            }

            Election updated_election = electionDAO.getElectionByID(election_id);
            request.setAttribute("election", updated_election);
            request.setAttribute("error", "Failed to cancel the election");
            request.getRequestDispatcher("/views/staff/election.modify.jsp").forward(request, response);
    }

    private void closeElection(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

            int election_id = Integer.parseInt(request.getParameter("election_id"));
            String status = "closed";

            if (electionDAO.updateElectionStatus(election_id, status) != null) {
                response.sendRedirect(request.getContextPath() + "/elections/page/" + election_id);
                return;
            }

            Election updated_election = electionDAO.getElectionByID(election_id);
            request.setAttribute("election", updated_election);
            request.setAttribute("error", "Failed to close the election");
            request.getRequestDispatcher("/views/staff/election.modify.jsp").forward(request, response);
    }
}
