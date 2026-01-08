/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ecems.controller;

import java.io.IOException;
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
@WebServlet("/elections/page/*")
public class electionPageServlet extends HttpServlet {

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
        
    }

}
