package com.ecems.model;

import java.io.Serializable;

public class Staff implements Serializable
{
    private int staff_id, campus_id;
    private String staff_number, password;

    public Staff() { }

    public Staff(int staff_id, int campus_id, String staff_number, String password)
    {
        this.staff_id = staff_id;
        this.campus_id = campus_id;
        this.staff_number = staff_number;
        this.password = password;
    }

    public int getStaff_id() { return staff_id; }
    public int getCampus_id() { return campus_id; }
    public String getStaff_number() { return staff_number; }
    public String getPassword() { return password; }

    public void setStaff_id(int staff_id) { this.staff_id = staff_id; }
    public void setCampus_id(int campus_id) { this.campus_id = campus_id; }
    public void setStaff_number(String staff_number) { this.staff_number = staff_number; }
    public void setPassword(String password) { this.password = password; }
}
