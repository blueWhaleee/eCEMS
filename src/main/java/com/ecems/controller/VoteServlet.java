package com.ecems.controller;

import com.ecems.model.User;
import  java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/VoteServlet")
public class VoteServlet extends HttpServlet
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
        
        
        String candidateId = request.getParameter("candidateId");
        String electionId = request.getParameter("electionId");
        
        
        session.setAttribute("voted_" + electionId, candidateId);
        
        
        response.sendRedirect("post.jsp?election=" + electionId + "&voted=true");
    }
}