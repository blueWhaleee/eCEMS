package com.ecems.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class StaffDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private static final String GET_STAFF_BY_STAFFNUM =
        "SELECT * FROM STAFFS WHERE STAFF_NUMBER = ?"; 
}
