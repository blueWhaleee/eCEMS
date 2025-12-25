/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ecems.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 *
 * @author SYAFIQ
 */
public class DBConnection {
    private static final String JDBC_URL = "jdbc:postgresql://aws-1-ap-northeast-1.pooler.supabase.com:5432/postgres";
    private static final String USER = "postgres.oiuusqzyuhorissjgjez";
    private static final String PASSWORD = "17Ncy9YvLtJrYqfg";
    
    public static Connection createConnection() {
        
        try {
            String driver = "org.postgresql.Driver";        
            Class.forName(driver);
            return DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
        } catch(ClassNotFoundException | SQLException ex) {     
            ex.printStackTrace();
        }
        return null;
    }
}
