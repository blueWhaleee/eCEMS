package com.ecems.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Campus implements Serializable
{
    private int campus_id;
    private String campus_code, campus_name;
    private LocalDateTime created_at;

    public Campus() { }

    public Campus(int campus_id, String campus_code, String campus_name, LocalDateTime created_at)
    {
        this.campus_id = campus_id;
        this.campus_code = campus_code;
        this.campus_name = campus_name;
        this.created_at = created_at;
    }

    public int getCampus_id() { return campus_id; }
    public String getCampus_code() { return campus_code; }
    public String getCampus_name() { return campus_name; }
    public LocalDateTime getCreated_at() { return created_at; }

    public void setCampus_id(int campus_id) { this.campus_id = campus_id; }
    public void setCampus_code(String campus_code) { this.campus_code = campus_code; }
    public void setCampus_name(String campus_name) { this.campus_name = campus_name; }
    public void setCreated_at(LocalDateTime created_at) { this.created_at = created_at; }
}
