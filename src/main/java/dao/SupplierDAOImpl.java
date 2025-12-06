package dao;

import dao.interfaces.SupplierDAO;
import model.Supplier;
import config.DIContainer;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * SupplierDAO implementation using JDBC
 * 
 * Features:
 * - Complete CRUD operations for suppliers
 * - Advanced search and filtering
 * - Proper error handling and logging
 * - SQL injection prevention
 * 
 * @author IoTBay Team
 * @version 2.0
 */
public class SupplierDAOImpl implements SupplierDAO {

    private static final Logger logger = Logger.getLogger(SupplierDAOImpl.class.getName());

    // SQL Queries
    private static final String INSERT_SUPPLIER = "INSERT INTO suppliers (contact_name, company_name, email, phone_number, "
            +
            "address_line1, address_line2, city, state, postal_code, country, " +
            "website, supplier_type, is_active, created_at, updated_at) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String SELECT_ALL_SUPPLIERS = "SELECT * FROM suppliers ORDER BY company_name, contact_name";

    private static final String SELECT_SUPPLIER_BY_ID = "SELECT * FROM suppliers WHERE id = ?";

    private static final String SELECT_SUPPLIERS_BY_CONTACT_NAME = "SELECT * FROM suppliers WHERE LOWER(contact_name) LIKE LOWER(?) ORDER BY contact_name";

    private static final String SELECT_SUPPLIERS_BY_COMPANY_NAME = "SELECT * FROM suppliers WHERE LOWER(company_name) LIKE LOWER(?) ORDER BY company_name";

    private static final String SELECT_SUPPLIERS_BY_TYPE = "SELECT * FROM suppliers WHERE supplier_type = ? ORDER BY company_name";

    private static final String SELECT_ACTIVE_SUPPLIERS = "SELECT * FROM suppliers WHERE is_active = true ORDER BY company_name, contact_name";

    private static final String SEARCH_SUPPLIERS = "SELECT * FROM suppliers WHERE " +
            "LOWER(contact_name) LIKE LOWER(?) OR " +
            "LOWER(company_name) LIKE LOWER(?) OR " +
            "LOWER(email) LIKE LOWER(?) " +
            "ORDER BY company_name, contact_name";

    private static final String SELECT_SUPPLIERS_WITH_PAGINATION = "SELECT * FROM suppliers ORDER BY company_name, contact_name LIMIT ? OFFSET ?";

    private static final String UPDATE_SUPPLIER = "UPDATE suppliers SET contact_name = ?, company_name = ?, email = ?, "
            +
            "phone_number = ?, address_line1 = ?, address_line2 = ?, city = ?, " +
            "state = ?, postal_code = ?, country = ?, website = ?, supplier_type = ?, " +
            "is_active = ?, updated_at = ? WHERE id = ?";

    private static final String UPDATE_SUPPLIER_STATUS = "UPDATE suppliers SET is_active = ?, updated_at = ? WHERE id = ?";

    private static final String DELETE_SUPPLIER = "DELETE FROM suppliers WHERE id = ?";

    private static final String COUNT_ALL_SUPPLIERS = "SELECT COUNT(*) FROM suppliers";

    private static final String COUNT_SUPPLIERS_BY_TYPE = "SELECT COUNT(*) FROM suppliers WHERE supplier_type = ?";

    private static final String CHECK_EMAIL_EXISTS = "SELECT COUNT(*) FROM suppliers WHERE LOWER(email) = LOWER(?) AND id != ?";

    private static final String CHECK_COMPANY_NAME_EXISTS = "SELECT COUNT(*) FROM suppliers WHERE LOWER(company_name) = LOWER(?) AND id != ?";

    public SupplierDAOImpl() {
        // No-arg constructor
    }

    @Override
    public Supplier createSupplier(Supplier supplier) throws SQLException {
        logger.info("Creating new supplier: " + supplier.getCompanyName());

        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(INSERT_SUPPLIER,
                        Statement.RETURN_GENERATED_KEYS)) {
            setSupplierParameters(statement, supplier);

            int affectedRows = statement.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating supplier failed, no rows affected.");
            }

            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    supplier.setId(generatedKeys.getInt(1));
                    logger.info("Supplier created successfully with ID: " + supplier.getId());
                    return supplier;
                } else {
                    throw new SQLException("Creating supplier failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error creating supplier", e);
            throw e;
        }
    }

    @Override
    public List<Supplier> getAllSuppliers() throws SQLException {
        logger.info("Retrieving all suppliers");

        List<Supplier> suppliers = new ArrayList<>();
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(SELECT_ALL_SUPPLIERS);
                ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                suppliers.add(mapResultSetToSupplier(rs));
            }

            logger.info("Retrieved " + suppliers.size() + " suppliers");
            return suppliers;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving all suppliers", e);
            throw e;
        }
    }

    @Override
    public Supplier getSupplierById(int id) throws SQLException {
        logger.info("Retrieving supplier by ID: " + id);

        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(SELECT_SUPPLIER_BY_ID)) {
            statement.setInt(1, id);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    Supplier supplier = mapResultSetToSupplier(rs);
                    logger.info("Supplier found: " + supplier.getCompanyName());
                    return supplier;
                } else {
                    logger.info("No supplier found with ID: " + id);
                    return null;
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving supplier by ID: " + id, e);
            throw e;
        }
    }

    @Override
    public List<Supplier> getSuppliersByContactName(String contactName) throws SQLException {
        logger.info("Searching suppliers by contact name: " + contactName);

        List<Supplier> suppliers = new ArrayList<>();
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(SELECT_SUPPLIERS_BY_CONTACT_NAME)) {
            statement.setString(1, "%" + contactName + "%");

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    suppliers.add(mapResultSetToSupplier(rs));
                }
            }

            logger.info("Found " + suppliers.size() + " suppliers matching contact name: " + contactName);
            return suppliers;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error searching suppliers by contact name", e);
            throw e;
        }
    }

    @Override
    public List<Supplier> getSuppliersByCompanyName(String companyName) throws SQLException {
        logger.info("Searching suppliers by company name: " + companyName);

        List<Supplier> suppliers = new ArrayList<>();
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(SELECT_SUPPLIERS_BY_COMPANY_NAME)) {
            statement.setString(1, "%" + companyName + "%");

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    suppliers.add(mapResultSetToSupplier(rs));
                }
            }

            logger.info("Found " + suppliers.size() + " suppliers matching company name: " + companyName);
            return suppliers;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error searching suppliers by company name", e);
            throw e;
        }
    }

    @Override
    public List<Supplier> getSuppliersByType(String supplierType) throws SQLException {
        logger.info("Retrieving suppliers by type: " + supplierType);

        List<Supplier> suppliers = new ArrayList<>();
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(SELECT_SUPPLIERS_BY_TYPE)) {
            statement.setString(1, supplierType);

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    suppliers.add(mapResultSetToSupplier(rs));
                }
            }

            logger.info("Found " + suppliers.size() + " suppliers of type: " + supplierType);
            return suppliers;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving suppliers by type", e);
            throw e;
        }
    }

    @Override
    public List<Supplier> getActiveSuppliers() throws SQLException {
        logger.info("Retrieving active suppliers");

        List<Supplier> suppliers = new ArrayList<>();
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(SELECT_ACTIVE_SUPPLIERS);
                ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                suppliers.add(mapResultSetToSupplier(rs));
            }

            logger.info("Retrieved " + suppliers.size() + " active suppliers");
            return suppliers;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving active suppliers", e);
            throw e;
        }
    }

    public List<Supplier> getInactiveSuppliers() throws SQLException {
        logger.info("Retrieving inactive suppliers");

        String query = "SELECT * FROM suppliers WHERE is_active = false ORDER BY company_name, contact_name";
        List<Supplier> suppliers = new ArrayList<>();
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query);
                ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                suppliers.add(mapResultSetToSupplier(rs));
            }

            logger.info("Retrieved " + suppliers.size() + " inactive suppliers");
            return suppliers;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving inactive suppliers", e);
            throw e;
        }
    }

    @Override
    public List<Supplier> searchSuppliers(String keyword) throws SQLException {
        logger.info("Searching suppliers with keyword: " + keyword);

        List<Supplier> suppliers = new ArrayList<>();
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(SEARCH_SUPPLIERS)) {
            String searchPattern = "%" + keyword + "%";
            statement.setString(1, searchPattern);
            statement.setString(2, searchPattern);
            statement.setString(3, searchPattern);

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    suppliers.add(mapResultSetToSupplier(rs));
                }
            }

            logger.info("Found " + suppliers.size() + " suppliers matching keyword: " + keyword);
            return suppliers;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error searching suppliers", e);
            throw e;
        }
    }

    @Override
    public List<Supplier> getSuppliersWithPagination(int offset, int limit) throws SQLException {
        logger.info("Retrieving suppliers with pagination: offset=" + offset + ", limit=" + limit);

        List<Supplier> suppliers = new ArrayList<>();
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(SELECT_SUPPLIERS_WITH_PAGINATION)) {
            statement.setInt(1, limit);
            statement.setInt(2, offset);

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    suppliers.add(mapResultSetToSupplier(rs));
                }
            }

            logger.info("Retrieved " + suppliers.size() + " suppliers with pagination");
            return suppliers;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving suppliers with pagination", e);
            throw e;
        }
    }

    @Override
    public boolean updateSupplier(Supplier supplier) throws SQLException {
        logger.info("Updating supplier: " + supplier.getCompanyName());

        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(UPDATE_SUPPLIER)) {
            setSupplierParametersForUpdate(statement, supplier);

            int affectedRows = statement.executeUpdate();
            boolean success = affectedRows > 0;

            if (success) {
                logger.info("Supplier updated successfully: " + supplier.getId());
            } else {
                logger.warning("No supplier updated with ID: " + supplier.getId());
            }

            return success;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error updating supplier", e);
            throw e;
        }
    }

    @Override
    public boolean updateSupplierStatus(int supplierId, boolean isActive) throws SQLException {
        logger.info("Updating supplier status: ID=" + supplierId + ", active=" + isActive);

        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(UPDATE_SUPPLIER_STATUS)) {
            statement.setBoolean(1, isActive);
            statement.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            statement.setInt(3, supplierId);

            int affectedRows = statement.executeUpdate();
            boolean success = affectedRows > 0;

            if (success) {
                logger.info("Supplier status updated successfully: " + supplierId);
            } else {
                logger.warning("No supplier status updated with ID: " + supplierId);
            }

            return success;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error updating supplier status", e);
            throw e;
        }
    }

    @Override
    public boolean deleteSupplier(int supplierId) throws SQLException {
        logger.info("Deleting supplier: " + supplierId);

        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(DELETE_SUPPLIER)) {
            statement.setInt(1, supplierId);

            int affectedRows = statement.executeUpdate();
            boolean success = affectedRows > 0;

            if (success) {
                logger.info("Supplier deleted successfully: " + supplierId);
            } else {
                logger.warning("No supplier deleted with ID: " + supplierId);
            }

            return success;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error deleting supplier", e);
            throw e;
        }
    }

    @Override
    public int getTotalSupplierCount() throws SQLException {
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(COUNT_ALL_SUPPLIERS);
                ResultSet rs = statement.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error counting suppliers", e);
            throw e;
        }
    }

    @Override
    public int getSupplierCountByType(String supplierType) throws SQLException {
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(COUNT_SUPPLIERS_BY_TYPE)) {
            statement.setString(1, supplierType);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
                return 0;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error counting suppliers by type", e);
            throw e;
        }
    }

    @Override
    public boolean isEmailExists(String email, int excludeId) throws SQLException {
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(CHECK_EMAIL_EXISTS)) {
            statement.setString(1, email);
            statement.setInt(2, excludeId);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
                return false;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error checking email existence", e);
            throw e;
        }
    }

    @Override
    public boolean isCompanyNameExists(String companyName, int excludeId) throws SQLException {
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(CHECK_COMPANY_NAME_EXISTS)) {
            statement.setString(1, companyName);
            statement.setInt(2, excludeId);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
                return false;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error checking company name existence", e);
            throw e;
        }
    }

    // Helper methods
    private void setSupplierParameters(PreparedStatement statement, Supplier supplier) throws SQLException {
        statement.setString(1, supplier.getContactName());
        statement.setString(2, supplier.getCompanyName());
        statement.setString(3, supplier.getEmail());
        statement.setString(4, supplier.getPhoneNumber());
        statement.setString(5, supplier.getAddressLine1());
        statement.setString(6, supplier.getAddressLine2());
        statement.setString(7, supplier.getCity());
        statement.setString(8, supplier.getState());
        statement.setString(9, supplier.getPostalCode());
        statement.setString(10, supplier.getCountry());
        statement.setString(11, supplier.getWebsite());
        statement.setString(12, supplier.getSupplierType());
        statement.setBoolean(13, supplier.isActive());
        statement.setTimestamp(14, Timestamp.valueOf(supplier.getCreatedAt()));
        statement.setTimestamp(15, Timestamp.valueOf(supplier.getUpdatedAt()));
    }

    private void setSupplierParametersForUpdate(PreparedStatement statement, Supplier supplier) throws SQLException {
        statement.setString(1, supplier.getContactName());
        statement.setString(2, supplier.getCompanyName());
        statement.setString(3, supplier.getEmail());
        statement.setString(4, supplier.getPhoneNumber());
        statement.setString(5, supplier.getAddressLine1());
        statement.setString(6, supplier.getAddressLine2());
        statement.setString(7, supplier.getCity());
        statement.setString(8, supplier.getState());
        statement.setString(9, supplier.getPostalCode());
        statement.setString(10, supplier.getCountry());
        statement.setString(11, supplier.getWebsite());
        statement.setString(12, supplier.getSupplierType());
        statement.setBoolean(13, supplier.isActive());
        statement.setTimestamp(14, Timestamp.valueOf(LocalDateTime.now()));
        statement.setInt(15, supplier.getId());
    }

    private Supplier mapResultSetToSupplier(ResultSet rs) throws SQLException {
        return new Supplier(
                rs.getInt("id"),
                rs.getString("contact_name"),
                rs.getString("company_name"),
                rs.getString("email"),
                rs.getString("phone_number"),
                rs.getString("address_line1"),
                rs.getString("address_line2"),
                rs.getString("city"),
                rs.getString("state"),
                rs.getString("postal_code"),
                rs.getString("country"),
                rs.getString("website"),
                rs.getString("supplier_type"),
                rs.getBoolean("is_active"),
                rs.getTimestamp("created_at").toLocalDateTime(),
                rs.getTimestamp("updated_at").toLocalDateTime());
    }

    // Compatibility methods for controller
    public Supplier findByEmail(String email) throws SQLException {
        String query = "SELECT * FROM suppliers WHERE email = ?";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, email);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToSupplier(rs);
                }
            }
        }
        return null;
    }

    public Supplier create(Supplier supplier) throws SQLException {
        return createSupplier(supplier);
    }

    public Supplier findById(Integer id) throws SQLException {
        return getSupplierById(id);
    }

    public boolean update(Supplier supplier) throws SQLException {
        return updateSupplier(supplier);
    }

    public boolean delete(Integer id) throws SQLException {
        return deleteSupplier(id);
    }

    public List<Supplier> findAll() throws SQLException {
        return getAllSuppliers();
    }

    public List<Supplier> findActiveSuppliers() throws SQLException {
        return getActiveSuppliers();
    }

    public List<Supplier> findInactiveSuppliers() throws SQLException {
        return getInactiveSuppliers();
    }

    public boolean hasAssociatedProducts(Integer supplierId) throws SQLException {
        // Simple implementation - check if supplier has products
        String query = "SELECT COUNT(*) FROM products WHERE supplier_id = ?";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, supplierId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    public int getProductCount(Integer supplierId) throws SQLException {
        String query = "SELECT COUNT(*) FROM products WHERE supplier_id = ?";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, supplierId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public int getActiveProductCount(Integer supplierId) throws SQLException {
        String query = "SELECT COUNT(*) FROM products WHERE supplier_id = ? AND is_active = true";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, supplierId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public List<Supplier> findByContactName(String contactName) throws SQLException {
        return getSuppliersByContactName(contactName);
    }

    public List<Supplier> findByCompanyName(String companyName) throws SQLException {
        String query = "SELECT * FROM suppliers WHERE LOWER(company_name) LIKE LOWER(?) ORDER BY company_name";
        List<Supplier> suppliers = new ArrayList<>();
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, "%" + companyName + "%");
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    suppliers.add(mapResultSetToSupplier(rs));
                }
            }
        }
        return suppliers;
    }

    public List<Supplier> findByCity(String city) throws SQLException {
        String query = "SELECT * FROM suppliers WHERE LOWER(city) LIKE LOWER(?) ORDER BY company_name";
        List<Supplier> suppliers = new ArrayList<>();
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, "%" + city + "%");
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    suppliers.add(mapResultSetToSupplier(rs));
                }
            }
        }
        return suppliers;
    }

    public List<Supplier> findByCountry(String country) throws SQLException {
        String query = "SELECT * FROM suppliers WHERE LOWER(country) LIKE LOWER(?) ORDER BY company_name";
        List<Supplier> suppliers = new ArrayList<>();
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, "%" + country + "%");
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    suppliers.add(mapResultSetToSupplier(rs));
                }
            }
        }
        return suppliers;
    }
}
