/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ecems.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDateTime;

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
        int election_id = Integer.parseInt(pathInfo.substring(1));
        
        Election election = electionDAO.getElectionByID(election_id);
        if (election != null) {
            String status = election.getStatus();
            String view;

            switch(status) {
                case "upcoming":
                    view = "/views/student/page.upcoming.jsp";
                    break;

                case "active":
                    view = "/views/student/page.active.jsp";
                    break;

                case "closed":
                    view = "/views/student/page.closed.jsp";
                    break;

                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
            }

            request.setAttribute("election", election);
            request.getRequestDispatcher(view).forward(request, response);
            return;
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
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
        request.getRequestDispatcher("/views/student/page.upcoming.jsp").forward(request, response);
    }

}
