/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ecems.dao;

import com.ecems.model.Student;
import com.ecems.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;

/**
 *
 * @author ASUS
 */
public class StudentDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private static final String INSERT_STUDENT_SQL =
        "INSERT INTO STUDENTS (full_name, stud_number, email, password, is_active, campus_id, faculty_id, profile_path) VALUES (?, ?, ?, ?, TRUE, ?, ?, ?)";

    private static final String GET_STUDENT_BY_STUDNUM_PASSWORD =
        "SELECT * FROM STUDENTS WHERE STUD_NUMBER = ? AND PASSWORD = ?";

    private static final String GET_STUDENT_BY_STUDNUM =
        "SELECT * FROM STUDENTS WHERE STUD_NUMBER = ?";

    // Used by registerServlet
    public Student createStudent(Student student) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(INSERT_STUDENT_SQL);

            pstmt.setString(1, student.getFull_name());
            pstmt.setString(2, student.getStud_number());
            pstmt.setString(3, student.getEmail());
            pstmt.setString(4, student.getPassword());
            pstmt.setInt(5, student.getCampus_id());
            pstmt.setInt(6, student.getFaculty_id());
            pstmt.setString(7, student.getProfile_path());
            pstmt.executeUpdate();

            pstmt.close();
            conn.close();

            return authenticateStudent(student);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Used by loginServlet
    public Student authenticateStudent(Student student) {
        String stud_number = student.getStud_number();
        String password = student.getPassword();
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(GET_STUDENT_BY_STUDNUM_PASSWORD);

            pstmt.setString(1, stud_number);
            pstmt.setString(2, password);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return extractStudent(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Student checkStudentNumber(String stud_number) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(GET_STUDENT_BY_STUDNUM);

            pstmt.setString(1, stud_number);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return extractStudent(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Student extractStudent(ResultSet rs) throws SQLException {
        int stud_id = rs.getInt("stud_id");
        int campus_id = rs.getInt("campus_id");
        int faculty_id = rs.getInt("faculty_id");
        String full_name = rs.getString("full_name");
        String stud_number = rs.getString("stud_number");
        String email = rs.getString("email");
        String password = rs.getString("password");
        boolean is_active = rs.getBoolean("is_active");
        LocalDateTime created_at = rs.getTimestamp("created_at").toLocalDateTime();
        String profile_path = rs.getString("profile_path");

        return new Student(stud_id, campus_id, faculty_id, full_name, stud_number, email, password, is_active, created_at, profile_path);
    }
}
