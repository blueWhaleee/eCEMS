package com.ecems.model;

public class user
{
    private String studentNo;
    private String password;
    private String role;
    private String fullName;
    
    public user()
    {
        
    }
    
    public user(String studentNo, String password, String role, String fullName)
    {
        this.studentNo = studentNo;
        this.password = password;
        this.role = role;
        this.fullName = fullName;
    }
    
    
    
    public String getStudentNo()
    {
        return studentNo;
    }
    
    public String getPassword()
    {
        return password;
    }
    
    public String getRole()
    {
        return role;
    }
    
    public String getFullName()
    {
        return fullName;
    }
    
    
    
    public void setStudentNo(String studentNo)
    {
        this.studentNo = studentNo;
    }
    
    public void setPassword(String password)
    {
        this.password = password;
    }
    
    public void setRole(String role)
    {
        this.role = role;
    }
    
    public void setFullName(String fullName)
    {
        this.fullName = fullName;
    }
}
