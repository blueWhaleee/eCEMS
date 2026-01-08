package com.ecems.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Faculty implements Serializable
{
    private int faculty_id, campus_id;
    private String faculty_code, faculty_name;
    private LocalDateTime created_at;

    public Faculty() { }

    public Faculty(int faculty_id, int campus_id, String faculty_code,
                   String faculty_name, LocalDateTime created_at)
    {
        this.faculty_id = faculty_id;
        this.campus_id = campus_id;
        this.faculty_code = faculty_code;
        this.faculty_name = faculty_name;
        this.created_at = created_at;
    }

    public int getFaculty_id() { return faculty_id; }
    public int getCampus_id() { return campus_id; }
    public String getFaculty_code() { return faculty_code; }
    public String getFaculty_name() { return faculty_name; }
    public LocalDateTime getCreated_at() { return created_at; }

    public void setFaculty_id(int faculty_id) { this.faculty_id = faculty_id; }
    public void setCampus_id(int campus_id) { this.campus_id = campus_id; }
    public void setFaculty_code(String faculty_code) { this.faculty_code = faculty_code; }
    public void setFaculty_name(String faculty_name) { this.faculty_name = faculty_name; }
    public void setCreated_at(LocalDateTime created_at) { this.created_at = created_at; }
}
