package com.ecems.controller;

import com.ecems.model.User;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CandidateRegistrationServlet")
public class CandidateRegistrationServlet extends HttpServlet
{
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null)
        {
            response.sendRedirect("login.jsp");
            return;
        }
        
        User usr = (User) session.getAttribute("loggedInUser");
        String slogan = request.getParameter("slogan");
        String manifesto = request.getParameter("manifesto");
        String electionId = request.getParameter("electionId");
        
        // 1. Get or create candidates list for this election
        List<Object[]> candidates = 
            (List<Object[]>) session.getAttribute("candidates_" + electionId);
        
        if (candidates == null)
        {
            candidates = new ArrayList<>();
        }
        

        Object[] candidate = new Object[]
        {
            candidates.size() + 1,
            usr.getFullName(),
            slogan,
            manifesto,
            usr.getStudentNo(),             
            usr.getRole()
        };
        
        
        candidates.add(candidate);
        session.setAttribute("candidates_" + electionId, candidates);
        

        session.setAttribute("candidate_reg_" + electionId, "pending");
        

        response.sendRedirect("post.jsp?election=" + electionId + "&registered=true");
    }
}