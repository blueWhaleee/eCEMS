/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ecems.controller;

import java.io.IOException;
import java.time.LocalDateTime;

import com.ecems.dao.ElectionDAO;
import com.ecems.model.Election;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */
@WebServlet("/elections/create")
public class electionCreateServlet extends HttpServlet {

    private ElectionDAO electionDAO;

    @Override
    public void init() throws ServletException {
       
    	// Initialize DAO object. Called once when servlet loads. 
    	electionDAO = new ElectionDAO();
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
        
        request.getRequestDispatcher("/views/staff/election.create.jsp").forward(request, response);
        return;   
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

            int created_by = Integer.parseInt(request.getParameter("created_by"));
            int campus_id = Integer.parseInt(request.getParameter("campus_id"));
            
            int max_votes = Integer.parseInt(request.getParameter("max_votes"));

            String facultyStr = request.getParameter("faculty_id");
            Integer faculty_id = (facultyStr != null && !facultyStr.isEmpty()) ? Integer.parseInt(facultyStr) : null;

            boolean isFacultySpecific = request.getParameter("is_faculty_specific") != null;
            String facultyIdStr = request.getParameter("faculty_id");
            String election_type;
            if (isFacultySpecific && facultyIdStr != null && !facultyIdStr.isEmpty()) {
                faculty_id = Integer.parseInt(facultyIdStr);
                election_type = "faculty";
            } else {
                election_type = null;
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
            election.setCreated_by(created_by);
            election.setCandidacy_open(candidacy_open);
            election.setMax_votes(max_votes);

            if (electionDAO.createElection(election) != null) {
                response.sendRedirect(request.getContextPath() + "/elections");
                return;
            } else {
                request.setAttribute("error", "Failed to create an election");
                request.getRequestDispatcher("/views/staff/election.create.jsp").forward(request, response);
            }
    }
}
