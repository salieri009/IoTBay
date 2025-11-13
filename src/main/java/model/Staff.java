package model;

import java.sql.Timestamp;

public class Staff extends User {
    private String department;
    private String jobTitle;
    private String employeeId;
    private String supervisorId;
    private String permissions;
    
    // Default constructor
    public Staff() {
        super();
        setRole("STAFF");
    }
    
    // Constructor with all fields
    public Staff(int id, String email, String passwordHash, String firstName, 
                String lastName, String phone, String dob, boolean isActive,
                Timestamp createdAt, Timestamp updatedAt, String department,
                String jobTitle, String employeeId, String supervisorId, String permissions) {
        super(id, email, passwordHash, firstName, lastName, phone, dob, 
              isActive, createdAt, updatedAt, "STAFF");
        this.department = department;
        this.jobTitle = jobTitle;
        this.employeeId = employeeId;
        this.supervisorId = supervisorId;
        this.permissions = permissions;
    }
    
    // Constructor without ID (for new staff)
    public Staff(String email, String passwordHash, String firstName, 
                String lastName, String phone, String dob, String department,
                String jobTitle, String employeeId, String supervisorId, String permissions) {
        super(email, passwordHash, firstName, lastName, phone, dob, "STAFF");
        this.department = department;
        this.jobTitle = jobTitle;
        this.employeeId = employeeId;
        this.supervisorId = supervisorId;
        this.permissions = permissions;
    }
    
    // Getters and Setters
    public String getDepartment() {
        return department;
    }
    
    public void setDepartment(String department) {
        this.department = department;
    }
    
    public String getJobTitle() {
        return jobTitle;
    }
    
    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }
    
    public String getEmployeeId() {
        return employeeId;
    }
    
    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }
    
    public String getSupervisorId() {
        return supervisorId;
    }
    
    public void setSupervisorId(String supervisorId) {
        this.supervisorId = supervisorId;
    }
    
    public String getPermissions() {
        return permissions;
    }
    
    public void setPermissions(String permissions) {
        this.permissions = permissions;
    }
    
    @Override
    public String toString() {
        return "Staff{" +
               "id=" + getId() +
               ", email='" + getEmail() + '\'' +
               ", firstName='" + getFirstName() + '\'' +
               ", lastName='" + getLastName() + '\'' +
               ", phone='" + getPhone() + '\'' +
               ", dob='" + getDob() + '\'' +
               ", isActive=" + isActive() +
               ", department='" + department + '\'' +
               ", jobTitle='" + jobTitle + '\'' +
               ", employeeId='" + employeeId + '\'' +
               ", supervisorId='" + supervisorId + '\'' +
               ", permissions='" + permissions + '\'' +
               ", createdAt=" + getCreatedAt() +
               ", updatedAt=" + getUpdatedAt() +
               '}';
    }
}
