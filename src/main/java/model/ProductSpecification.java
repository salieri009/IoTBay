package model;

import java.io.Serializable;

/**
 * Product Specification Model for IoT Products
 * Stores technical specifications required for IoT device compatibility checking
 * 
 * Based on improvement.md recommendations for enhanced product information architecture
 */
public class ProductSpecification implements Serializable {
    private int productId;
    private String communicationProtocol; // LoRaWAN, Zigbee, WiFi, Bluetooth, MQTT, etc.
    private String voltage; // e.g., "12V DC", "24V DC", "5V USB"
    private String operatingRange; // e.g., "-40°C to 85°C"
    private String powerConsumption; // e.g., "100mA @ 12V"
    private String frequency; // e.g., "2.4GHz", "915MHz"
    private String range; // e.g., "100m indoor", "1km outdoor"
    private String certifications; // e.g., "CE, FCC, RoHS"
    private String compatibility; // JSON string of compatible products/platforms
    private String datasheetUrl;
    private String integrationGuideUrl;
    private String apiDocumentationUrl;
    
    // Default constructor
    public ProductSpecification() {
    }
    
    // Constructor
    public ProductSpecification(int productId, String communicationProtocol, String voltage, 
                                String operatingRange, String powerConsumption) {
        this.productId = productId;
        this.communicationProtocol = communicationProtocol;
        this.voltage = voltage;
        this.operatingRange = operatingRange;
        this.powerConsumption = powerConsumption;
    }
    
    // Getters and Setters
    public int getProductId() {
        return productId;
    }
    
    public void setProductId(int productId) {
        this.productId = productId;
    }
    
    public String getCommunicationProtocol() {
        return communicationProtocol;
    }
    
    public void setCommunicationProtocol(String communicationProtocol) {
        this.communicationProtocol = communicationProtocol;
    }
    
    public String getVoltage() {
        return voltage;
    }
    
    public void setVoltage(String voltage) {
        this.voltage = voltage;
    }
    
    public String getOperatingRange() {
        return operatingRange;
    }
    
    public void setOperatingRange(String operatingRange) {
        this.operatingRange = operatingRange;
    }
    
    public String getPowerConsumption() {
        return powerConsumption;
    }
    
    public void setPowerConsumption(String powerConsumption) {
        this.powerConsumption = powerConsumption;
    }
    
    public String getFrequency() {
        return frequency;
    }
    
    public void setFrequency(String frequency) {
        this.frequency = frequency;
    }
    
    public String getRange() {
        return range;
    }
    
    public void setRange(String range) {
        this.range = range;
    }
    
    public String getCertifications() {
        return certifications;
    }
    
    public void setCertifications(String certifications) {
        this.certifications = certifications;
    }
    
    public String getCompatibility() {
        return compatibility;
    }
    
    public void setCompatibility(String compatibility) {
        this.compatibility = compatibility;
    }
    
    public String getDatasheetUrl() {
        return datasheetUrl;
    }
    
    public void setDatasheetUrl(String datasheetUrl) {
        this.datasheetUrl = datasheetUrl;
    }
    
    public String getIntegrationGuideUrl() {
        return integrationGuideUrl;
    }
    
    public void setIntegrationGuideUrl(String integrationGuideUrl) {
        this.integrationGuideUrl = integrationGuideUrl;
    }
    
    public String getApiDocumentationUrl() {
        return apiDocumentationUrl;
    }
    
    public void setApiDocumentationUrl(String apiDocumentationUrl) {
        this.apiDocumentationUrl = apiDocumentationUrl;
    }
    
    /**
     * Check if this product has essential specifications
     */
    public boolean hasEssentialSpecs() {
        return communicationProtocol != null && !communicationProtocol.trim().isEmpty() &&
               voltage != null && !voltage.trim().isEmpty();
    }
    
    @Override
    public String toString() {
        return "ProductSpecification{" +
                "productId=" + productId +
                ", communicationProtocol='" + communicationProtocol + '\'' +
                ", voltage='" + voltage + '\'' +
                ", operatingRange='" + operatingRange + '\'' +
                ", powerConsumption='" + powerConsumption + '\'' +
                '}';
    }
}

