package com.ecems.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Candidate implements Serializable
{
    private int candidate_id, election_id, student_id, updated_by_staff;
    private String manifesto, photo_url, banner_url, slogan, status, elected_position;
    private LocalDateTime created_at;

    public Candidate() { }

    public Candidate(int candidate_id, int election_id, int student_id, int updated_by_staff,
                     String manifesto, String photo_url, String banner_url,
                     String slogan, String status, String elected_position,
                     LocalDateTime created_at)
    {
        this.candidate_id = candidate_id;
        this.election_id = election_id;
        this.student_id = student_id;
        this.updated_by_staff = updated_by_staff;
        this.manifesto = manifesto;
        this.photo_url = photo_url;
        this.banner_url = banner_url;
        this.slogan = slogan;
        this.status = status;
        this.elected_position = elected_position;
        this.created_at = created_at;
    }

    public int getCandidate_id() { return candidate_id; }
    public int getElection_id() { return election_id; }
    public int getStudent_id() { return student_id; }
    public int getUpdated_by_staff() { return updated_by_staff; }
    public String getManifesto() { return manifesto; }
    public String getPhoto_url() { return photo_url; }
    public String getBanner_url() { return banner_url; }
    public String getSlogan() { return slogan; }
    public String getStatus() { return status; }
    public String getElected_position() { return elected_position; }
    public LocalDateTime getCreated_at() { return created_at; }

    public void setCandidate_id(int candidate_id) { this.candidate_id = candidate_id; }
    public void setElection_id(int election_id) { this.election_id = election_id; }
    public void setStudent_id(int student_id) { this.student_id = student_id; }
    public void setUpdated_by_staff(int updated_by_staff) { this.updated_by_staff = updated_by_staff; }
    public void setManifesto(String manifesto) { this.manifesto = manifesto; }
    public void setPhoto_url(String photo_url) { this.photo_url = photo_url; }
    public void setBanner_url(String banner_url) { this.banner_url = banner_url; }
    public void setSlogan(String slogan) { this.slogan = slogan; }
    public void setStatus(String status) { this.status = status; }
    public void setElected_position(String elected_position) { this.elected_position = elected_position; }
    public void setCreated_at(LocalDateTime created_at) { this.created_at = created_at; }
}
