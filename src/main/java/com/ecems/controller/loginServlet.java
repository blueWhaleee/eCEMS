/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ecems.controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.ecems.dao.StaffDAO;
import com.ecems.dao.StudentDAO;
import com.ecems.model.Staff;
import com.ecems.model.Student;
import com.ecems.util.passwordHash;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
@WebServlet("/login")
public class loginServlet extends HttpServlet {

    private StudentDAO studentDAO;
    private StaffDAO staffDAO;

    @Override
    public void init() throws ServletException {
       
    	// Initialize DAO object. Called once when servlet loads. 
    	studentDAO = new StudentDAO();
        staffDAO = new StaffDAO();
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
        RequestDispatcher view = request.getRequestDispatcher("/views/login.jsp");
        view.forward(request, response);
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

        List<String> errors = new ArrayList<>();
        String is_staff = request.getParameter("is_staff");
        String number = request.getParameter("number");
        String password = request.getParameter("password");
        
        if (number == null || number.isEmpty()) 
            errors.add("Student number cannot be empty");
        if (password == null || password.isEmpty()) 
            errors.add("Password cannot be empty");
        
        if (is_staff == null) {
            if (errors.isEmpty()) {
                Student student = new Student();
                student.setStud_number(number);
                student.setPassword(passwordHash.doHashing(password));
                
                Student new_student = studentDAO.authenticateStudent(student);
                if (new_student != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("loggedUser", new_student);
                    session.setAttribute("role", "student");
    
                    response.sendRedirect(request.getContextPath() + "/");
                    return;
                } else {
                    errors.add("Wrong student number or password");
                }
            }
        } else {
            if (errors.isEmpty()) {
                Staff staff = new Staff();
                staff.setStaff_number(number);
                staff.setPassword(passwordHash.doHashing(password));
                
                Staff new_staff = staffDAO.authenticateStaff(staff);
                if (new_staff != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("loggedUser", new_staff);
                    session.setAttribute("role", "staff");
    
                    response.sendRedirect(request.getContextPath() + "/");
                    return;
                } else {
                    errors.add("Wrong staff number or password");
                }
            }
        }

        request.setAttribute("errors", errors);
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

}
