package com.ecems.dao;

import com.ecems.model.Staff;
import com.ecems.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StaffDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private static final String INSERT_STAFF_SQL =
        "INSERT INTO STAFFS (staff_number, password, campus_id) VALUES (?, ?, ?)";

    private static final String GET_STAFF_BY_STAFFNUM_PASSWORD =
        "SELECT * FROM STAFFS WHERE STAFF_NUMBER = ? AND PASSWORD = ?";

    private static final String GET_STAFF_BY_STAFFNUM =
        "SELECT * FROM STAFFS WHERE STAFF_NUMBER = ?";

    // Create a new staff record
    public Staff createStaff(Staff staff) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(INSERT_STAFF_SQL);

            pstmt.setString(1, staff.getStaff_number());
            pstmt.setString(2, staff.getPassword());
            pstmt.setInt(3, staff.getCampus_id());
            pstmt.setString(3, staff.getFull_name());
            pstmt.executeUpdate();

            pstmt.close();
            conn.close();

            return authenticateStaff(staff);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Authenticate staff login
    public Staff authenticateStaff(Staff staff) {
        String staff_number = staff.getStaff_number();
        String password = staff.getPassword();
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(GET_STAFF_BY_STAFFNUM_PASSWORD);

            pstmt.setString(1, staff_number);
            pstmt.setString(2, password);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return extractStaff(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } 
        return null;
    }

    // Check if staff number already exists
    public Staff checkStaffNumber(String staff_number) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(GET_STAFF_BY_STAFFNUM);

            pstmt.setString(1, staff_number);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return extractStaff(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Staff extractStaff(ResultSet rs) throws SQLException {
        int staff_id = rs.getInt("staff_id");
        int campus_id = rs.getInt("campus_id");
        String staff_number = rs.getString("staff_number");
        String password = rs.getString("password");
        String full_name = rs.getString("full_name");
        String profile_path = rs.getString("profile_path");

        return new Staff(staff_id, campus_id, staff_number, password, full_name, profile_path);
    }

}