/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ecems.dao;

import com.ecems.model.Candidate;
import com.ecems.model.Vote;
import com.ecems.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;

/**
 *
 * @author ACER
 */
public class VoteDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private static final String INSERT_VOTES_SQL = 
        "INSERT INTO VOTES " +
        "(STUDENT_ID, CANDIDATE_ID) " +
        "VALUES (?, ?)";

    private static final String CHECK_VOTE_SQL = 
        "SELECT V.* FROM VOTES V " +
        "JOIN CANDIDATES C ON V.CANDIDATE_ID = C.CANDIDATE_ID " +
        "WHERE V.STUDENT_ID = ? AND C.ELECTION_ID = ?";
        
    public boolean createVote(Vote vote) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(INSERT_VOTES_SQL);

            pstmt.setInt(1, vote.getStudent_id());
            pstmt.setInt(2, vote.getCandidate_id());

            int rowAffected = pstmt.executeUpdate();
            return rowAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        } 
        return false;
    }

    public boolean checkVoted(int student_id, int election_id) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(CHECK_VOTE_SQL);
            pstmt.setInt(1, student_id);
            pstmt.setInt(2, election_id);
            rs = pstmt.executeQuery();

            return rs.next(); // If there's a result, the student has voted

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Vote extractVote(ResultSet rs) throws SQLException {
        Vote vote = new Vote();
        
        vote.setStudent_id(rs.getInt("student_id"));
        vote.setCandidate_id(rs.getInt("candidate_id"));
        vote.setCreated_at(rs.getObject("created_at", LocalDateTime.class));

        return vote;
    }
}
