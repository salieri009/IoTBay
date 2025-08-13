package model;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class User implements Serializable {
    private int id;
    private String email;
    private String firstName;
    private String lastName;
    private String password;

    private String phone;
    private String postalCode;
    private String addressLine1;
    private String addressLine2;
    private String paymentMethod;
    // private String gender;
    // we don't need a gender field for e-commerce website
    // private String favoriteColor;
    //we dont need a favorite color field for e-commerce website
    private LocalDate dateOfBirth;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String role;
    private boolean isActive;

    // Default constructor
    public User() {
    }

    public User(int id, String email, String password, String firstName, String lastName,
                String phone, String postalCode, String addressLine1, String addressLine2,
                LocalDate dateOfBirth, String paymentMethod,
                LocalDateTime createdAt, LocalDateTime updatedAt,
                String role, boolean isActive)  {
        this.id = id;
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.password = password;
        this.phone = phone;
        this.postalCode = postalCode;
        this.addressLine1 = addressLine1;
        this.addressLine2 = addressLine2;
        this.paymentMethod = paymentMethod;
        //

        this.dateOfBirth = dateOfBirth;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.role = role;
        this.isActive = isActive;
    }

    public int getId() {
        return id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    // Alias methods for compatibility
    public String getPhoneNumber() {
        return phone;
    }

    public void setPhoneNumber(String phone) {
        this.phone = phone;
    }

    // public String getGender() {
    //     return gender;
    // }

    // public void setGender(String gender) {
    //     this.gender = gender;
    // }

    // public String getFavoriteColor() {
    //     return favoriteColor;
    // }

    // public void setFavoriteColor(String favoriteColor) {
    //     this.favoriteColor = favoriteColor;
    // }

    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(LocalDate dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public void deactivate() {
        this.isActive = false;
    }

    public String getFullName() {
        return firstName + " " + lastName;
    }

    public String getDateOfBirthAsString() {
        return dateOfBirth != null ? dateOfBirth.toString() : null;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public String getAddressLine1() {
        return addressLine1;
    }

    public String getAddressLine2() {
        return addressLine2;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }
    public void setAddressLine1(String addressLine1) {
        this.addressLine1 = addressLine1;
    }
    public void setAddressLine2(String addressLine2) {
        this.addressLine2 = addressLine2;
    }
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
    

    public String getPaymentMethod() {
        return paymentMethod;
    }
}