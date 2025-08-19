package dao;

import model.Shipment;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ShipmentDAO {
    private final Connection connection;

    public ShipmentDAO(Connection connection) {
        this.connection = connection;
    }

    // CREATE
    public void createShipment(Shipment shipment) throws SQLException {
        String query = "INSERT INTO shipment (order_id, address_id, shipping_date, shipping_status) VALUES (?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, shipment.getOrderId());
            statement.setInt(2, shipment.getAddressId());
            statement.setObject(3, shipment.getShippingDate());
            statement.setString(4, shipment.getShippingStatus());
            statement.executeUpdate();
        }
    }

    // READ by ID
    public Shipment getShipmentById(int id) throws SQLException {
        String query = "SELECT * FROM shipment WHERE shipment_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return new Shipment(
                        rs.getInt("shipment_id"),
                        rs.getInt("order_id"),
                        rs.getInt("address_id"),
                        rs.getObject("shipping_date", LocalDateTime.class),
                        rs.getString("shipping_status")
                    );
                }
            }
        }
        return null;
    }

    // UPDATE
    public void updateShipment(Shipment shipment) throws SQLException {
        String query = "UPDATE shipment SET shipping_date = ?, shipping_status = ? WHERE shipment_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setObject(1, shipment.getShippingDate());
            statement.setString(2, shipment.getShippingStatus());
            statement.setInt(3, shipment.getId());
            statement.executeUpdate();
        }
    }

    // DELETE
    public void deleteShipment(int id) throws SQLException {
        String query = "DELETE FROM shipment WHERE shipment_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        }
    }

    // READ All by orderId
    public List<Shipment> getShipmentsByOrderId(int orderId) throws SQLException {
        String query = "SELECT * FROM shipment WHERE order_id = ?";
        List<Shipment> shipments = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, orderId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    shipments.add(new Shipment(
                        rs.getInt("shipment_id"),
                        rs.getInt("order_id"),
                        rs.getInt("address_id"),
                        rs.getObject("shipping_date", LocalDateTime.class),
                        rs.getString("shipping_status")
                    ));
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
        String query = "SELECT * FROM shipment";
        List<Shipment> shipments = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    shipments.add(new Shipment(
                        rs.getInt("shipment_id"),
                        rs.getInt("order_id"),
                        rs.getInt("address_id"),
                        rs.getObject("shipping_date", LocalDateTime.class),
                        rs.getString("shipping_status")
                    ));
                }
            }
        }
        return shipments;
    }

    public List<Shipment> findByUserId(int userId) throws SQLException {
        String query = "SELECT s.* FROM shipment s JOIN orders o ON s.order_id = o.order_id WHERE o.user_id = ?";
        List<Shipment> shipments = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    shipments.add(new Shipment(
                        rs.getInt("shipment_id"),
                        rs.getInt("order_id"),
                        rs.getInt("address_id"),
                        rs.getObject("shipping_date", LocalDateTime.class),
                        rs.getString("shipping_status")
                    ));
                }
            }
        }
        return shipments;
    }

    public Shipment findByTrackingNumber(String trackingNumber) throws SQLException {
        // For now, return null as tracking number field needs to be added to database
        return null;
    }

    public List<Shipment> searchShipments(Integer userId, String status, String startDate, String endDate) throws SQLException {
        StringBuilder query = new StringBuilder("SELECT s.* FROM shipment s");
        if (userId != null) {
            query.append(" JOIN orders o ON s.order_id = o.order_id WHERE o.user_id = ?");
        } else {
            query.append(" WHERE 1=1");
        }
        
        if (status != null && !status.isEmpty()) {
            query.append(" AND s.shipping_status = ?");
        }
        
        List<Shipment> shipments = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query.toString())) {
            int paramIndex = 1;
            if (userId != null) {
                statement.setInt(paramIndex++, userId);
            }
            if (status != null && !status.isEmpty()) {
                statement.setString(paramIndex++, status);
            }
            
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    shipments.add(new Shipment(
                        rs.getInt("shipment_id"),
                        rs.getInt("order_id"),
                        rs.getInt("address_id"),
                        rs.getObject("shipping_date", LocalDateTime.class),
                        rs.getString("shipping_status")
                    ));
                }
            }
        }
        return shipments;
    }
}