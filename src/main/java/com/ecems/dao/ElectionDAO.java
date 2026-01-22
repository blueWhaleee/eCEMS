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

    private static final String UPDATE_ELECTION_SQL =
        "UPDATE ELECTIONS " +
        "SET TITLE = ?, " +
        "DESCRIPTION = ?, " +
        "SESSION = ?, " +
        "ELECTION_TYPE = ?, " +
        "START_DATE = ?, " +
        "END_DATE = ?, " +
        "STATUS = ?, " +
        "CAMPUS_ID = ?, " +
        "FACULTY_ID = ?, " +
        "CANDIDACY_OPEN = ?, " +
        "MAX_VOTES = ? " +
        "WHERE ELECTION_ID = ? ";

    private static final String CHANGE_ELECTION_STATUS =
        "UPDATE ELECTIONS " +
        "SET STATUS = ? " +
        "WHERE ELECTION_ID = ? ";

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
        } finally {
            // Close resources in reverse order of creation
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
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

            if (election.getFaculty_id() != 0) {
                pstmt.setInt(9, election.getFaculty_id());
            } else {
                pstmt.setNull(9, java.sql.Types.INTEGER);
            }

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

    public Election updateElectionByID(Election election) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(UPDATE_ELECTION_SQL);

            pstmt.setString(1, election.getTitle());
            pstmt.setString(2, election.getDescription());
            pstmt.setString(3, election.getSession());
            pstmt.setString(4, election.getElection_type());
            pstmt.setTimestamp(5, java.sql.Timestamp.valueOf(election.getStart_date()));
            pstmt.setTimestamp(6, java.sql.Timestamp.valueOf(election.getEnd_date()));
            pstmt.setString(7, election.getStatus());
            pstmt.setInt(8, election.getCampus_id());

            if (election.getFaculty_id() != 0) {
                pstmt.setInt(9, election.getFaculty_id());
            } else {
                pstmt.setNull(9, java.sql.Types.INTEGER);
            }

            pstmt.setBoolean(10, election.isCandidacy_open());
            pstmt.setInt(11, election.getMax_votes());
            pstmt.setInt(12, election.getElection_id());

            pstmt.executeUpdate();

            pstmt.close();
            conn.close();

            return getElectionByID(election.getElection_id());

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Election updateElectionStatus(int election_id, String status) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(CHANGE_ELECTION_STATUS);

            pstmt.setString(1, status);
            pstmt.setInt(2, election_id);

            pstmt.executeUpdate();

            pstmt.close();
            conn.close();

            return getElectionByID(election_id);

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
