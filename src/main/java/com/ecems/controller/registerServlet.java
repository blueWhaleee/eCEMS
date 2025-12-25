/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ecems.controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.ecems.dao.StudentDAO;
import com.ecems.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */
@WebServlet("/register")
public class registerServlet extends HttpServlet {

    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
       
    	// Initialize DAO object. Called once when servlet loads. 
    	studentDAO = new StudentDAO();
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
        RequestDispatcher view = request.getRequestDispatcher("/views/register.jsp");
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

        String full_name = request.getParameter("full_name");
        String stud_number = request.getParameter("stud_number");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        int campus_id = Integer.parseInt(request.getParameter("campus_id"));
        int faculty_id = Integer.parseInt(request.getParameter("faculty_id"));

        if (full_name == null || full_name.isEmpty() || full_name.length() < 6) 
            errors.add("Full name must be at least 6 characters");
        if (stud_number == null || stud_number.isEmpty() || stud_number.length() != 10) 
            errors.add("Student number must be 10 digits");
        if (email == null || email.isEmpty() || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) 
            errors.add("Email must be in valid format");
        if (password == null || password.isEmpty() || password.length() < 6) 
            errors.add("Password must be at least 6 characters");
        if (campus_id == -1) 
            errors.add("Choose a campus");
        if (faculty_id == -1) 
            errors.add("Chhoose a faculty");
        if (studentDAO.checkStudentNumber(stud_number) != null)
            errors.add("Student number is already registered");

        if (errors.isEmpty()) {
            Student student = new Student();
            student.setFull_name(full_name);
            student.setStud_number(stud_number);
            student.setEmail(email);
            student.setPassword(password);
            student.setCampus_id(campus_id);
            student.setFaculty_id(faculty_id);

            if (studentDAO.createStudent(student) != null)
                response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        }

    }


}
