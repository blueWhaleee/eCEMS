package com.ecems.controller;

import com.ecems.model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.*;
import jakarta.servlet.http.*;


public class NavigationServlet extends HttpServlet
{
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        HttpSession session = request.getSession();
        User usr = (User) session.getAttribute("loggedInUser");
        
        if(usr == null)
        {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String page = request.getParameter("page");
        
        if("home".equals(page))
        {
            if("Staff".equals(usr.getRole()))
            {
                response.sendRedirect("home_staff.jsp");
            }
            else
            {
                response.sendRedirect("home.jsp");
            }
        }
        
        else if ("eelctions".equals(page))
        {
            response.sendRedirect("elections.jsp");
        }
        
        else if ("logout".equals(page))
        {
            session.invalidate();
            response.sendRedirect("login.jsp");
        }
        
        else
        {
            response.sendRedirect("home.jsp");
        }
    }
}