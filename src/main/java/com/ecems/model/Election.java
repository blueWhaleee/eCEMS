package com.ecems.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Election implements Serializable
{
    private int election_id, campus_id, faculty_id, created_by, max_votes;
    private String title, description, session, election_type, status;
    private LocalDateTime start_date, end_date, created_at;
    private boolean candidacy_open;

    public Election() { }

    public Election(int election_id, int campus_id, int faculty_id, int created_by, int max_votes,
                    String title, String description, String session, String election_type,
                    String status, LocalDateTime start_date, LocalDateTime end_date,
                    LocalDateTime created_at, boolean candidacy_open)
    {
        this.election_id = election_id;
        this.campus_id = campus_id;
        this.faculty_id = faculty_id;
        this.created_by = created_by;
        this.max_votes = max_votes;
        this.title = title;
        this.description = description;
        this.session = session;
        this.election_type = election_type;
        this.status = status;
        this.start_date = start_date;
        this.end_date = end_date;
        this.created_at = created_at;
        this.candidacy_open = candidacy_open;
    }

    public int getElection_id() { return election_id; }
    public int getCampus_id() { return campus_id; }
    public int getFaculty_id() { return faculty_id; }
    public int getCreated_by() { return created_by; }
    public int getMax_votes() { return max_votes; }
    public String getTitle() { return title; }
    public String getDescription() { return description; }
    public String getSession() { return session; }
    public String getElection_type() { return election_type; }
    public String getStatus() { return status; }
    public LocalDateTime getStart_date() { return start_date; }
    public LocalDateTime getEnd_date() { return end_date; }
    public LocalDateTime getCreated_at() { return created_at; }
    public boolean isCandidacy_open() { return candidacy_open; }

    public void setElection_id(int election_id) { this.election_id = election_id; }
    public void setCampus_id(int campus_id) { this.campus_id = campus_id; }
    public void setFaculty_id(int faculty_id) { this.faculty_id = faculty_id; }
    public void setCreated_by(int created_by) { this.created_by = created_by; }
    public void setMax_votes(int max_votes) { this.max_votes = max_votes; }
    public void setTitle(String title) { this.title = title; }
    public void setDescription(String description) { this.description = description; }
    public void setSession(String session) { this.session = session; }
    public void setElection_type(String election_type) { this.election_type = election_type; }
    public void setStatus(String status) { this.status = status; }
    public void setStart_date(LocalDateTime start_date) { this.start_date = start_date; }
    public void setEnd_date(LocalDateTime end_date) { this.end_date = end_date; }
    public void setCreated_at(LocalDateTime created_at) { this.created_at = created_at; }
    public void setCandidacy_open(boolean candidacy_open) { this.candidacy_open = candidacy_open; }
}
