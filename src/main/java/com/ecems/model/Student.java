package com.ecems.model;
import java.io.Serializable;
import java.time.LocalDateTime;

public class Student implements Serializable
{
    private int stud_id, campus_id, faculty_id;
    private String full_name, stud_number, email, password, profile_path;
    private boolean is_active;
    private LocalDateTime created_at;
    
    public Student() { }
    
    public Student(int stud_id, int campus_id, int faculty_id, 
                   String full_name, String stud_number, String email, 
                   String password, boolean is_active, LocalDateTime created_at, String profile_path)
    {
        this.stud_id = stud_id;
        this.campus_id = campus_id;
        this.faculty_id = faculty_id;
        this.full_name = full_name;
        this.stud_number = stud_number;
        this.email = email;
        this.password = password;
        this.is_active = is_active;
        this.created_at = created_at;
        this.profile_path = profile_path;
    }
    
    public int getStud_id() { return stud_id; }
    public int getCampus_id() { return campus_id; }
    public int getFaculty_id() { return faculty_id; }
    public String getFull_name() { return full_name; }
    public String getStud_number() { return stud_number; }
    public String getEmail() { return email; }
    public String getPassword() { return password; }
    public boolean isIs_active() { return is_active; }
    public LocalDateTime getCreated_at() { return created_at; }
    public String getProfile_path() { return profile_path; }

    public void setStud_id(int stud_id) { this.stud_id = stud_id; }
    public void setCampus_id(int campus_id) { this.campus_id = campus_id; }
    public void setFaculty_id(int faculty_id) { this.faculty_id = faculty_id; }
    public void setFull_name(String full_name) { this.full_name = full_name; }
    public void setStud_number(String stud_number) { this.stud_number = stud_number; }
    public void setEmail(String email) { this.email = email; }
    public void setPassword(String password) { this.password = password; }
    public void setIs_active(boolean is_active) { this.is_active = is_active; }
    public void setCreated_at(LocalDateTime created_at) { this.created_at = created_at; }
    public void setProfile_path(String profile_path) { this.profile_path = profile_path; }
}
