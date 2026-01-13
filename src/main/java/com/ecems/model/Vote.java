package com.ecems.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Vote implements Serializable
{
    private int student_id, candidate_id;
    private LocalDateTime created_at;

    public Vote() { }

    public Vote(int student_id, int candidate_id, Integer rank)
    {
        this.student_id = student_id;
        this.candidate_id = candidate_id;
    }

    public int getStudent_id() { return student_id; }
    public int getCandidate_id() { return candidate_id; }
    public LocalDateTime getCreated_at() { return created_at; }

    public void setStudent_id(int student_id) { this.student_id = student_id; }
    public void setCandidate_id(int candidate_id) { this.candidate_id = candidate_id; }
    public void setCreated_at(LocalDateTime created_at) { this.created_at = created_at; }
}
