package com.ecems.dao;

import com.ecems.model.Candidate;
import com.ecems.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;

/**
 * DAO for Candidate Management
 * @author ASUS
 */
public class CandidateDAO {

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private static final String INSERT_CANDIDATE_SQL = 
        "INSERT INTO candidates " +
        "(manifesto, photo_url, banner_url, slogan, election_id, student_id) " +
        "VALUES (?, ?, ?, ?, ?, ?)";

    public boolean createCandidate(Candidate candidate) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(INSERT_CANDIDATE_SQL);

            pstmt.setString(1, candidate.getManifesto());
            pstmt.setString(2, candidate.getPhoto_url());
            pstmt.setString(3, candidate.getBanner_url());
            pstmt.setString(4, candidate.getSlogan());
            pstmt.setInt(5, candidate.getElection_id());
            pstmt.setInt(6, candidate.getStudent_id());

            int rowAffected = pstmt.executeUpdate();
            return rowAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        } 
        return false;
    }

    private Candidate extractCandidate(ResultSet rs) throws SQLException {
        Candidate candidate = new Candidate();
        
        candidate.setCandidate_id(rs.getInt("candidate_id"));
        candidate.setElection_id(rs.getInt("election_id"));
        candidate.setStudent_id(rs.getInt("student_id"));
        candidate.setUpdated_by_staff(rs.getInt("updated_by_staff"));
        
        candidate.setManifesto(rs.getString("manifesto"));
        candidate.setPhoto_url(rs.getString("photo_url"));
        candidate.setBanner_url(rs.getString("banner_url"));
        candidate.setSlogan(rs.getString("slogan"));
        candidate.setStatus(rs.getString("status"));
        candidate.setElected_position(rs.getString("elected_position"));
        
        candidate.setCreated_at(rs.getObject("created_at", LocalDateTime.class));
        
        return candidate;
    }

}