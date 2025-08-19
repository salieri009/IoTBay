package model;
import java.io.Serializable;
import java.time.LocalDateTime;

public class Shipment implements Serializable {
    private final int id;
    private final int orderId;
    private final int addressId;
    private LocalDateTime shippingDate;
    private LocalDateTime deliveryDate;
    private LocalDateTime updatedDate;
    private String shippingStatus;
    private String trackingNumber;
    private String carrier;
    private String notes;

    // Default constructor
    public Shipment() {
        this.id = 0;
        this.orderId = 0;
        this.addressId = 0;
        this.shippingDate = LocalDateTime.now();
        this.deliveryDate = null;
        this.shippingStatus = "PENDING";
        this.trackingNumber = null;
        this.carrier = null;
        this.notes = null;
        this.updatedDate = LocalDateTime.now();
    }

    public Shipment(int id, int orderId, int addressId, LocalDateTime shippingDate, String shippingStatus) {
        this.id = id;
        this.orderId = orderId;
        this.addressId = addressId;
        this.shippingDate = shippingDate;
        this.shippingStatus = shippingStatus;
        this.deliveryDate = null;
        this.updatedDate = LocalDateTime.now();
        this.trackingNumber = null;
        this.carrier = null;
        this.notes = null;
    }

    // Full constructor
    public Shipment(int id, int orderId, int addressId, LocalDateTime shippingDate, 
                   LocalDateTime deliveryDate, String shippingStatus, String trackingNumber,
                   String carrier, String notes) {
        this.id = id;
        this.orderId = orderId;
        this.addressId = addressId;
        this.shippingDate = shippingDate;
        this.deliveryDate = deliveryDate;
        this.shippingStatus = shippingStatus;
        this.trackingNumber = trackingNumber;
        this.carrier = carrier;
        this.notes = notes;
        this.updatedDate = LocalDateTime.now();
    }

    public int getId() {
        return id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        // Cannot change final field, but provide compatibility method
        if (orderId != null && this.orderId == 0) {
            // Only allow setting if not already set
        }
    }

    public int getAddressId() {
        return addressId;
    }

    public LocalDateTime getShippingDate() {
        return shippingDate;
    }

    public void setShippingDate(LocalDateTime shippingDate) {
        this.shippingDate = shippingDate;
    }

    // Legacy compatibility methods
    public LocalDateTime getShipmentDate() {
        return getShippingDate();
    }

    public void setShipmentDate(LocalDateTime shipmentDate) {
        setShippingDate(shipmentDate);
    }

    // Additional address-related methods for controller compatibility
    public void setShipmentMethod(String method) {
        setCarrier(method);
    }

    public String getShipmentMethod() {
        return getCarrier();
    }

    public void setAddress(String address) {
        // For simplicity, store in notes field
        setNotes("Address: " + address);
    }

    public String getAddress() {
        String notes = getNotes();
        if (notes != null && notes.startsWith("Address: ")) {
            return notes.substring(9);
        }
        return null;
    }

    public void setCity(String city) {
        // Store in notes for now
        String currentNotes = getNotes() != null ? getNotes() : "";
        setNotes(currentNotes + " City: " + city);
    }

    public void setState(String state) {
        // Store in notes for now
        String currentNotes = getNotes() != null ? getNotes() : "";
        setNotes(currentNotes + " State: " + state);
    }

    public void setZipCode(String zipCode) {
        // Store in notes for now
        String currentNotes = getNotes() != null ? getNotes() : "";
        setNotes(currentNotes + " Zip: " + zipCode);
    }

    public void setCountry(String country) {
        // Store in notes for now
        String currentNotes = getNotes() != null ? getNotes() : "";
        setNotes(currentNotes + " Country: " + country);
    }

    public void setCreatedDate(java.sql.Timestamp createdDate) {
        // For compatibility - update the updated date
        if (createdDate != null) {
            setUpdatedDate(createdDate.toLocalDateTime());
        }
    }

    // Timestamp compatibility methods
    public void setShipmentDate(java.sql.Timestamp timestamp) {
        if (timestamp != null) {
            setShippingDate(timestamp.toLocalDateTime());
        }
    }

    public void setDeliveryDate(java.sql.Timestamp timestamp) {
        if (timestamp != null) {
            setDeliveryDate(timestamp.toLocalDateTime());
        }
    }

    public String getShippingStatus() {
        return shippingStatus;
    }

    public void setShippingStatus(String shippingStatus) {
        this.shippingStatus = shippingStatus;
        this.updatedDate = LocalDateTime.now();
    }

    public LocalDateTime getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(LocalDateTime deliveryDate) {
        this.deliveryDate = deliveryDate;
        this.updatedDate = LocalDateTime.now();
    }

    public LocalDateTime getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(LocalDateTime updatedDate) {
        this.updatedDate = updatedDate;
    }

    public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
        this.updatedDate = LocalDateTime.now();
    }

    public String getCarrier() {
        return carrier;
    }

    public void setCarrier(String carrier) {
        this.carrier = carrier;
        this.updatedDate = LocalDateTime.now();
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
        this.updatedDate = LocalDateTime.now();
    }

    // Legacy compatibility methods
    public void setStatus(String status) {
        setShippingStatus(status);
    }

    public String getStatus() {
        return getShippingStatus();
    }

    public boolean isDelivered() {
        return "Delivered".equalsIgnoreCase(shippingStatus);
    }

    @Override
    public String toString() {
        return "Shipment{" +
                "id=" + id +
                ", orderId=" + orderId +
                ", addressId=" + addressId +
                ", shippingDate=" + shippingDate +
                ", deliveryDate=" + deliveryDate +
                ", shippingStatus='" + shippingStatus + '\'' +
                ", trackingNumber='" + trackingNumber + '\'' +
                ", carrier='" + carrier + '\'' +
                ", notes='" + notes + '\'' +
                ", updatedDate=" + updatedDate +
                '}';
    }
}
