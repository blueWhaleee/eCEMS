package com.ecems.dao;

import com.ecems.model.Election;
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
public class ElectionDAO {

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private static final String GET_ELECTION_BY_ID =
        "SELECT * FROM ELECTIONS WHERE ELECTION_ID = ?";

    private static final String INSERT_ELECTION_SQL =
        "INSERT INTO ELECTIONS " +
        "(title, description, session, election_type, start_date, end_date, " +
        "status, campus_id, faculty_id, created_by, candidacy_open, max_votes) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    public Election getElectionByID(int election_id) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(GET_ELECTION_BY_ID);

            pstmt.setInt(1, election_id);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                return extractElection(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Election createElection(Election election) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(INSERT_ELECTION_SQL);

            pstmt.setString(1, election.getTitle());
            pstmt.setString(2, election.getDescription());
            pstmt.setString(3, election.getSession());
            pstmt.setString(4, election.getElection_type());
            pstmt.setTimestamp(5, java.sql.Timestamp.valueOf(election.getStart_date()));
            pstmt.setTimestamp(6, java.sql.Timestamp.valueOf(election.getEnd_date()));
            pstmt.setString(7, election.getStatus());
            pstmt.setInt(8, election.getCampus_id());
            pstmt.setInt(9, election.getFaculty_id());
            pstmt.setInt(10, election.getCreated_by());
            pstmt.setBoolean(11, election.isCandidacy_open());
            pstmt.setInt(12, election.getMax_votes());

            pstmt.executeUpdate();

            pstmt.close();
            conn.close();

            return election;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Election extractElection(ResultSet rs) throws SQLException {

        int election_id = rs.getInt("election_id");
        int campus_id = rs.getInt("campus_id");
        int faculty_id = rs.getInt("faculty_id");
        int created_by = rs.getInt("created_by");
        int max_votes = rs.getInt("max_votes");

        String title = rs.getString("title");
        String description = rs.getString("description");
        String session = rs.getString("session");
        String election_type = rs.getString("election_type");
        String status = rs.getString("status");

        LocalDateTime start_date = rs.getObject("start_date", LocalDateTime.class);
        LocalDateTime end_date = rs.getObject("end_date", LocalDateTime.class);
        LocalDateTime created_at = rs.getObject("created_at", LocalDateTime.class);

        boolean candidacy_open = rs.getBoolean("candidacy_open");

        return new Election( election_id, campus_id, faculty_id, created_by, max_votes, title, description, session, election_type, status, start_date, end_date, created_at, candidacy_open );
    }
}
