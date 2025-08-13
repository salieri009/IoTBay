package dao.interfaces;

import model.Supplier;
import java.sql.SQLException;
import java.util.List;

/**
 * SupplierDAO interface defining data access operations for suppliers
 * 
 * Features:
 * - Full CRUD operations
 * - Search and filtering capabilities
 * - Status management (active/inactive)
 * - Pagination support
 * 
 * @author IoTBay Team
 * @version 2.0
 */
public interface SupplierDAO {
    
    // CREATE operations
    /**
     * Creates a new supplier in the database
     * @param supplier Supplier object to create
     * @return Created supplier with generated ID
     * @throws SQLException If database error occurs
     */
    Supplier createSupplier(Supplier supplier) throws SQLException;
    
    // READ operations
    /**
     * Retrieves all suppliers from the database
     * @return List of all suppliers
     * @throws SQLException If database error occurs
     */
    List<Supplier> getAllSuppliers() throws SQLException;
    
    /**
     * Retrieves a supplier by ID
     * @param id Supplier ID
     * @return Supplier object or null if not found
     * @throws SQLException If database error occurs
     */
    Supplier getSupplierById(int id) throws SQLException;
    
    /**
     * Retrieves suppliers by contact name
     * @param contactName Contact name to search for
     * @return List of matching suppliers
     * @throws SQLException If database error occurs
     */
    List<Supplier> getSuppliersByContactName(String contactName) throws SQLException;
    
    /**
     * Retrieves suppliers by company name
     * @param companyName Company name to search for
     * @return List of matching suppliers
     * @throws SQLException If database error occurs
     */
    List<Supplier> getSuppliersByCompanyName(String companyName) throws SQLException;
    
    /**
     * Retrieves suppliers by type
     * @param supplierType Type of supplier
     * @return List of matching suppliers
     * @throws SQLException If database error occurs
     */
    List<Supplier> getSuppliersByType(String supplierType) throws SQLException;
    
    /**
     * Retrieves active suppliers only
     * @return List of active suppliers
     * @throws SQLException If database error occurs
     */
    List<Supplier> getActiveSuppliers() throws SQLException;
    
    /**
     * Searches suppliers by keyword (searches contact name, company name, email)
     * @param keyword Search keyword
     * @return List of matching suppliers
     * @throws SQLException If database error occurs
     */
    List<Supplier> searchSuppliers(String keyword) throws SQLException;
    
    /**
     * Retrieves suppliers with pagination
     * @param offset Starting position
     * @param limit Number of records to return
     * @return List of suppliers
     * @throws SQLException If database error occurs
     */
    List<Supplier> getSuppliersWithPagination(int offset, int limit) throws SQLException;
    
    // UPDATE operations
    /**
     * Updates an existing supplier
     * @param supplier Supplier object with updated information
     * @return true if update was successful
     * @throws SQLException If database error occurs
     */
    boolean updateSupplier(Supplier supplier) throws SQLException;
    
    /**
     * Updates supplier status (active/inactive)
     * @param supplierId Supplier ID
     * @param isActive New status
     * @return true if update was successful
     * @throws SQLException If database error occurs
     */
    boolean updateSupplierStatus(int supplierId, boolean isActive) throws SQLException;
    
    // DELETE operations
    /**
     * Deletes a supplier from the database
     * @param supplierId Supplier ID to delete
     * @return true if deletion was successful
     * @throws SQLException If database error occurs
     */
    boolean deleteSupplier(int supplierId) throws SQLException;
    
    // UTILITY operations
    /**
     * Counts total number of suppliers
     * @return Total count
     * @throws SQLException If database error occurs
     */
    int getTotalSupplierCount() throws SQLException;
    
    /**
     * Counts suppliers by type
     * @param supplierType Type to count
     * @return Count of suppliers of specified type
     * @throws SQLException If database error occurs
     */
    int getSupplierCountByType(String supplierType) throws SQLException;
    
    /**
     * Checks if supplier email already exists
     * @param email Email to check
     * @param excludeId ID to exclude from check (for updates)
     * @return true if email exists
     * @throws SQLException If database error occurs
     */
    boolean isEmailExists(String email, int excludeId) throws SQLException;
    
    /**
     * Checks if supplier company name already exists
     * @param companyName Company name to check
     * @param excludeId ID to exclude from check (for updates)
     * @return true if company name exists
     * @throws SQLException If database error occurs
     */
    boolean isCompanyNameExists(String companyName, int excludeId) throws SQLException;
}
