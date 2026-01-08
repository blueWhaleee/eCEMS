package com.ecems.model;

import java.io.Serializable;

public class Vote implements Serializable
{
    private int student_id, candidate_id;
    private Integer rank;

    public Vote() { }

    public Vote(int student_id, int candidate_id, Integer rank)
    {
        this.student_id = student_id;
        this.candidate_id = candidate_id;
        this.rank = rank;
    }

    public int getStudent_id() { return student_id; }
    public int getCandidate_id() { return candidate_id; }
    public Integer getRank() { return rank; }

    public void setStudent_id(int student_id) { this.student_id = student_id; }
    public void setCandidate_id(int candidate_id) { this.candidate_id = candidate_id; }
    public void setRank(Integer rank) { this.rank = rank; }
}
