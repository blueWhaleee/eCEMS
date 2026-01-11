package com.ecems.dao;

import com.ecems.model.Candidate;
import com.ecems.model.Election;
import com.ecems.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for Candidate Management
 * @author ASUS
 */
public class CandidateDAO {

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private static final String INSERT_CANDIDATE_SQL = 
        "INSERT INTO CANDIDATES " +
        "(MANIFESTO, PHOTO_URL, BANNER_URL, SLOGAN, ELECTION_ID, STUDENT_ID) " +
        "VALUES (?, ?, ?, ?, ?, ?)";
    
    private static final String CHANGE_CANDIDATE_STATUS = 
        "UPDATE CANDIDATES SET STATUS = ? WHERE CANDIDATE_ID = ? ";

    private static final String GET_CANDIDATES_BY_ELECTIONID =
        "SELECT * FROM CANDIDATES WHERE STATUS = 'approved' AND ELECTION_ID = ? ";


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

    public boolean updateCandidateStatus(int candidate_id, String status) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(CHANGE_CANDIDATE_STATUS);

            pstmt.setString(1, status);
            pstmt.setInt(2, candidate_id);
            int rowAffected = pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();

            return rowAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Candidate> getApprovedCandidatesByElection(int election_id) {
        List<Candidate> candidates = new ArrayList<>();
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(GET_CANDIDATES_BY_ELECTIONID);
            pstmt.setInt(1, election_id);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                candidates.add(extractCandidate(rs));
            }
            
            rs.close();
            pstmt.close();
            conn.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return candidates;
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