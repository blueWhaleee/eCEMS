package com.ecems.controller;

import com.ecems.model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet
{
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String studentNo = request.getParameter("studentNo");
        String password = request.getParameter("password");
        
        User usr = new User();
        usr.setStudentNo(studentNo);
        usr.setPassword(password);
        
        if("admin".equalsIgnoreCase(studentNo) && "admin123".equalsIgnoreCase(password))
        {
            usr.setRole("Staff");
            usr.setFullName("Amer Syafiq bin Abdul Razak");
        }
        
        else
        {
            usr.setRole("Student");
            usr.setFullName(studentNo);
        }
        
        HttpSession session = request.getSession();
        session.setAttribute("loggedInUser", usr);
        
        if("Staff".equalsIgnoreCase(usr.getRole()))
        {
            response.sendRedirect("home_staff.jsp");
        }
        
        else
        {
            response.sendRedirect("home.jsp");
        }
    }
}