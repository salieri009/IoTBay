package dao;

import model.Shipment;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ShipmentDAO {

    public ShipmentDAO() {
    }

    /** Maps a result-set row (with all shipment columns) to a fully populated Shipment. */
    private Shipment mapRow(ResultSet rs) throws SQLException {
        Shipment s = new Shipment();
        s.setId(rs.getInt("shipment_id"));
        s.setOrderId(rs.getInt("order_id"));
        s.setAddressId(rs.getInt("address_id"));
        s.setShippingDate(rs.getObject("shipping_date", LocalDateTime.class));
        s.setDeliveryDate(rs.getObject("delivery_date", LocalDateTime.class));
        s.setShippingStatus(rs.getString("shipping_status"));
        s.setTrackingNumber(rs.getString("tracking_number"));
        s.setCarrier(rs.getString("carrier"));
        s.setNotes(rs.getString("notes"));
        return s;
    }

    // CREATE
    public void createShipment(Shipment shipment) throws SQLException {
        String query = "INSERT INTO shipment (order_id, address_id, shipping_date, delivery_date, "
                + "shipping_status, tracking_number, carrier, notes, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, datetime('now'), datetime('now'))";
        try (Connection connection = config.DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, shipment.getOrderId());
            statement.setInt(2, shipment.getAddressId());
            statement.setObject(3, shipment.getShippingDate());
            statement.setObject(4, shipment.getDeliveryDate());
            statement.setString(5, shipment.getShippingStatus());
            statement.setString(6, shipment.getTrackingNumber());
            statement.setString(7, shipment.getCarrier());
            statement.setString(8, shipment.getNotes());
            statement.executeUpdate();
        }
    }

    // READ by ID
    public Shipment getShipmentById(int id) throws SQLException {
        String query = "SELECT * FROM shipment WHERE shipment_id = ?";
        try (Connection connection = config.DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        }
        return null;
    }

    // UPDATE
    public void updateShipment(Shipment shipment) throws SQLException {
        String query = "UPDATE shipment SET shipping_date = ?, delivery_date = ?, shipping_status = ?, "
                + "tracking_number = ?, carrier = ?, notes = ?, updated_at = datetime('now') "
                + "WHERE shipment_id = ?";
        try (Connection connection = config.DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setObject(1, shipment.getShippingDate());
            statement.setObject(2, shipment.getDeliveryDate());
            statement.setString(3, shipment.getShippingStatus());
            statement.setString(4, shipment.getTrackingNumber());
            statement.setString(5, shipment.getCarrier());
            statement.setString(6, shipment.getNotes());
            statement.setInt(7, shipment.getId());
            statement.executeUpdate();
        }
    }

    // DELETE
    public void deleteShipment(int id) throws SQLException {
        String query = "DELETE FROM shipment WHERE shipment_id = ?";
        try (Connection connection = config.DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        }
    }

    // READ All by orderId
    public List<Shipment> getShipmentsByOrderId(int orderId) throws SQLException {
        String query = "SELECT * FROM shipment WHERE order_id = ?";
        List<Shipment> shipments = new ArrayList<>();
        try (Connection connection = config.DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, orderId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    shipments.add(mapRow(rs));
                }
            }
        }
        return shipments;
    }

    // Additional methods required by controller
    public void delete(Integer id) throws SQLException {
        deleteShipment(id);
    }

    public Shipment findById(Integer id) throws SQLException {
        return getShipmentById(id);
    }

    public void update(Shipment shipment) throws SQLException {
        updateShipment(shipment);
    }

    public void create(Shipment shipment) throws SQLException {
        createShipment(shipment);
    }

    public List<Shipment> findAll() throws SQLException {
        String query = "SELECT * FROM shipment ORDER BY shipment_id DESC";
        List<Shipment> shipments = new ArrayList<>();
        try (Connection connection = config.DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    shipments.add(mapRow(rs));
                }
            }
        }
        return shipments;
    }

    public List<Shipment> findByUserId(int userId) throws SQLException {
        // orders table is plural with PK "id"; join shipment.order_id -> orders.id
        String query = "SELECT s.* FROM shipment s JOIN orders o ON s.order_id = o.id "
                + "WHERE o.user_id = ? ORDER BY s.shipment_id DESC";
        List<Shipment> shipments = new ArrayList<>();
        try (Connection connection = config.DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    shipments.add(mapRow(rs));
                }
            }
        }
        return shipments;
    }

    public Shipment findByTrackingNumber(String trackingNumber) throws SQLException {
        if (trackingNumber == null || trackingNumber.trim().isEmpty()) {
            return null;
        }
        String query = "SELECT * FROM shipment WHERE tracking_number = ?";
        try (Connection connection = config.DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, trackingNumber.trim());
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        }
        return null;
    }

    public List<Shipment> searchShipments(Integer userId, String status, String startDate, String endDate)
            throws SQLException {
        StringBuilder query = new StringBuilder("SELECT s.* FROM shipment s");
        if (userId != null) {
            query.append(" JOIN orders o ON s.order_id = o.id WHERE o.user_id = ?");
        } else {
            query.append(" WHERE 1=1");
        }

        boolean hasStatus = status != null && !status.isEmpty();
        boolean hasStart = startDate != null && !startDate.isEmpty();
        boolean hasEnd = endDate != null && !endDate.isEmpty();

        if (hasStatus) {
            query.append(" AND s.shipping_status = ?");
        }
        if (hasStart) {
            query.append(" AND date(s.shipping_date) >= date(?)");
        }
        if (hasEnd) {
            query.append(" AND date(s.shipping_date) <= date(?)");
        }
        query.append(" ORDER BY s.shipment_id DESC");

        List<Shipment> shipments = new ArrayList<>();
        try (Connection connection = config.DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query.toString())) {
            int paramIndex = 1;
            if (userId != null) {
                statement.setInt(paramIndex++, userId);
            }
            if (hasStatus) {
                statement.setString(paramIndex++, status);
            }
            if (hasStart) {
                statement.setString(paramIndex++, startDate);
            }
            if (hasEnd) {
                statement.setString(paramIndex++, endDate);
            }

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    shipments.add(mapRow(rs));
                }
            }
        }
        return shipments;
    }
}
