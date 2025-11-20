package dao.stub;

import model.Supplier;
import dao.interfaces.SupplierDAO;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class SupplierDAOStub implements SupplierDAO {
    private final List<Supplier> suppliers = new ArrayList<>();

    public SupplierDAOStub() {
        // Comprehensive test data with 20+ test cases covering various scenarios
        // Test case 1-3: Electronics suppliers
        suppliers.add(new Supplier(1, "TechCore Electronics", "John Smith", "john.smith@techcore.com", "+61 2 9876 5432", "Sydney", "NSW", "2000", "Australia", "Electronics", true, LocalDateTime.now().minusDays(30)));
        suppliers.add(new Supplier(2, "DigiParts Ltd", "Sarah Johnson", "sarah@digiparts.com.au", "+61 3 9876 5432", "Melbourne", "VIC", "3000", "Australia", "Electronics", true, LocalDateTime.now().minusDays(25)));
        suppliers.add(new Supplier(3, "CircuitWorks Pty", "Michael Chen", "m.chen@circuitworks.com", "+61 7 9876 5432", "Brisbane", "QLD", "4000", "Australia", "Electronics", true, LocalDateTime.now().minusDays(20)));

        // Test case 4-6: Sensor manufacturers
        suppliers.add(new Supplier(4, "SensorTech Industries", "Emma Wilson", "emma@sensortech.com.au", "+61 2 5555 5555", "Sydney", "NSW", "2015", "Australia", "Sensors", true, LocalDateTime.now().minusDays(28)));
        suppliers.add(new Supplier(5, "Precision Sensors Inc", "David Lee", "david.lee@precisionsensors.com", "+61 8 4444 4444", "Perth", "WA", "6000", "Australia", "Sensors", true, LocalDateTime.now().minusDays(22)));
        suppliers.add(new Supplier(6, "MeasurePoint Solutions", "Lisa Anderson", "lisa@measurepoint.com", "+61 2 3333 3333", "Wollongong", "NSW", "2500", "Australia", "Sensors", false, LocalDateTime.now().minusDays(18)));

        // Test case 7-9: Microcontroller suppliers
        suppliers.add(new Supplier(7, "MicroElectronix", "James Taylor", "james@microelectronix.com.au", "+61 3 2222 2222", "Melbourne", "VIC", "3100", "Australia", "Microcontrollers", true, LocalDateTime.now().minusDays(26)));
        suppliers.add(new Supplier(8, "ControlSystems Pro", "Rachel Brown", "rachel@controlsys.com", "+61 7 1111 1111", "Gold Coast", "QLD", "4217", "Australia", "Microcontrollers", true, LocalDateTime.now().minusDays(23)));
        suppliers.add(new Supplier(9, "EmbeddedCore Ltd", "Peter Martinez", "peter@embeddedcore.com", "+61 2 6666 6666", "Canberra", "ACT", "2601", "Australia", "Microcontrollers", true, LocalDateTime.now().minusDays(19)));

        // Test case 10-12: Connectivity module suppliers
        suppliers.add(new Supplier(10, "ConnectTech Networks", "Jennifer Davis", "jen@connecttech.com.au", "+61 3 7777 7777", "Brisbane", "QLD", "4006", "Australia", "Connectivity", true, LocalDateTime.now().minusDays(27)));
        suppliers.add(new Supplier(11, "WirelessParts Distributor", "Christopher Green", "chris@wirelessparts.com", "+61 2 8888 8888", "Newcastle", "NSW", "2300", "Australia", "Connectivity", true, LocalDateTime.now().minusDays(24)));
        suppliers.add(new Supplier(12, "IoT Link Solutions", "Nicole Harris", "nicole@iotlink.com.au", "+61 8 9999 9999", "Adelaide", "SA", "5000", "Australia", "Connectivity", false, LocalDateTime.now().minusDays(21)));

        // Test case 13-15: Power and energy suppliers
        suppliers.add(new Supplier(13, "PowerSupply Corp", "Andrew White", "andrew@powersupply.com", "+61 7 1010 1010", "Toowoomba", "QLD", "4350", "Australia", "Power", true, LocalDateTime.now().minusDays(25)));
        suppliers.add(new Supplier(14, "EnergySource Distribution", "Victoria Clark", "victoria@energysource.com.au", "+61 2 1111 1111", "Penrith", "NSW", "2750", "Australia", "Power", true, LocalDateTime.now().minusDays(20)));
        suppliers.add(new Supplier(15, "BatteryWorld Australia", "Thomas Hill", "thomas@batteryworld.com", "+61 3 1212 1212", "Geelong", "VIC", "3220", "Australia", "Power", true, LocalDateTime.now().minusDays(17)));

        // Test case 16-18: Software and services
        suppliers.add(new Supplier(16, "SoftwareSolutions Aus", "Angela Martin", "angela@softwaresolutions.com.au", "+61 2 1313 1313", "Chatswood", "NSW", "2067", "Australia", "Software", true, LocalDateTime.now().minusDays(24)));
        suppliers.add(new Supplier(17, "ITServices Group", "Robert Thompson", "robert@itservices.com", "+61 3 1414 1414", "Docklands", "VIC", "3008", "Australia", "Software", true, LocalDateTime.now().minusDays(16)));
        suppliers.add(new Supplier(18, "CloudTech Provider", "Sophie Jackson", "sophie@cloudtech.com.au", "+61 7 1515 1515", "Fortitude Valley", "QLD", "4006", "Australia", "Software", false, LocalDateTime.now().minusDays(14)));

        // Test case 19-21: Inactive suppliers
        suppliers.add(new Supplier(19, "LegacyElectronics Ltd", "Mark Robinson", "mark@legacyelec.com", "+61 2 1616 1616", "Parramatta", "NSW", "2150", "Australia", "Electronics", false, LocalDateTime.now().minusDays(40)));
        suppliers.add(new Supplier(20, "OldTech Systems", "Karen Lewis", "karen@oldtech.com.au", "+61 3 1717 1717", "Brunswick", "VIC", "3056", "Australia", "Sensors", false, LocalDateTime.now().minusDays(35)));
        suppliers.add(new Supplier(21, "DeprecatedParts Inc", "George Walker", "george@deprecatedparts.com", "+61 8 1818 1818", "Fremantle", "WA", "6160", "Australia", "Microcontrollers", false, LocalDateTime.now().minusDays(30)));

        // Test case 22-24: International suppliers
        suppliers.add(new Supplier(22, "GlobalTech Singapore", "Wei Wong", "wei@globaltech.sg", "+65 6789 0123", "Singapore", "SG", "018956", "Singapore", "Electronics", true, LocalDateTime.now().minusDays(23)));
        suppliers.add(new Supplier(23, "AsianConnectivity Ltd", "Priya Kumar", "priya@asianconn.in", "+91 22 1234 5678", "Mumbai", "MH", "400001", "India", "Connectivity", true, LocalDateTime.now().minusDays(19)));
        suppliers.add(new Supplier(24, "EuroElectronics GmbH", "Klaus Mueller", "klaus@euroelec.de", "+49 30 1234 5678", "Berlin", "Berlin", "10115", "Germany", "Electronics", true, LocalDateTime.now().minusDays(15)));

        // Test case 25-27: Recently added suppliers
        suppliers.add(new Supplier(25, "NewTech Startup", "Alex Johnson", "alex@newtechstartup.com.au", "+61 2 2020 2020", "Surry Hills", "NSW", "2010", "Australia", "Electronics", true, LocalDateTime.now().minusDays(5)));
        suppliers.add(new Supplier(26, "InnovateSensor Corp", "Bella Martinez", "bella@innovatesensor.com", "+61 3 2121 2121", "South Melbourne", "VIC", "3205", "Australia", "Sensors", true, LocalDateTime.now().minusDays(3)));
        suppliers.add(new Supplier(27, "FutureConnectivity Ltd", "Daniel Scott", "daniel@futureconn.com.au", "+61 7 2222 2222", "Spring Hill", "QLD", "4004", "Australia", "Connectivity", true, LocalDateTime.now().minusDays(1)));

        // Test case 28-30: Mixed types and statuses
        suppliers.add(new Supplier(28, "Hybrid Solutions Aus", "Patricia Johnson", "patricia@hybridsolutions.com", "+61 2 2323 2323", "Macquarie Park", "NSW", "2113", "Australia", "Power", true, LocalDateTime.now().minusDays(10)));
        suppliers.add(new Supplier(29, "SpecializedParts Ltd", "Richard Anderson", "richard@specializedparts.com.au", "+61 3 2424 2424", "Collingwood", "VIC", "3066", "Australia", "Software", true, LocalDateTime.now().minusDays(8)));
        suppliers.add(new Supplier(30, "PremiumComponents Inc", "Sandra King", "sandra@premiumcomp.com", "+61 8 2525 2525", "East Perth", "WA", "6004", "Australia", "Electronics", false, LocalDateTime.now().minusDays(12)));
    }

    private int getNextId() {
        return suppliers.isEmpty() ? 1 : suppliers.get(suppliers.size() - 1).getId() + 1;
    }

    @Override
    public Supplier createSupplier(Supplier supplier) throws SQLException {
        Supplier newSupplier = new Supplier(
            getNextId(),
            supplier.getCompanyName(),
            supplier.getContactName(),
            supplier.getEmail(),
            supplier.getPhone(),
            supplier.getCity(),
            supplier.getState(),
            supplier.getPostalCode(),
            supplier.getCountry(),
            supplier.getSupplierType(),
            supplier.isActive(),
            LocalDateTime.now()
        );
        suppliers.add(newSupplier);
        return newSupplier;
    }

    @Override
    public List<Supplier> getAllSuppliers() throws SQLException {
        return new ArrayList<>(suppliers);
    }

    @Override
    public Supplier getSupplierById(int id) throws SQLException {
        return suppliers.stream()
                .filter(s -> s.getId() == id)
                .findFirst()
                .orElse(null);
    }

    @Override
    public List<Supplier> getSuppliersByContactName(String contactName) throws SQLException {
        return suppliers.stream()
                .filter(s -> s.getContactName().toLowerCase().contains(contactName.toLowerCase()))
                .collect(Collectors.toList());
    }

    @Override
    public List<Supplier> getSuppliersByCompanyName(String companyName) throws SQLException {
        return suppliers.stream()
                .filter(s -> s.getCompanyName().toLowerCase().contains(companyName.toLowerCase()))
                .collect(Collectors.toList());
    }

    @Override
    public List<Supplier> getSuppliersByType(String supplierType) throws SQLException {
        return suppliers.stream()
                .filter(s -> s.getSupplierType().equalsIgnoreCase(supplierType))
                .collect(Collectors.toList());
    }

    @Override
    public List<Supplier> getActiveSuppliers() throws SQLException {
        return suppliers.stream()
                .filter(Supplier::isActive)
                .collect(Collectors.toList());
    }

    @Override
    public List<Supplier> searchSuppliers(String keyword) throws SQLException {
        String lowerKeyword = keyword.toLowerCase();
        return suppliers.stream()
                .filter(s -> s.getCompanyName().toLowerCase().contains(lowerKeyword) ||
                           s.getContactName().toLowerCase().contains(lowerKeyword) ||
                           s.getEmail().toLowerCase().contains(lowerKeyword))
                .collect(Collectors.toList());
    }

    @Override
    public List<Supplier> getSuppliersWithPagination(int offset, int limit) throws SQLException {
        return suppliers.stream()
                .skip(offset)
                .limit(limit)
                .collect(Collectors.toList());
    }

    @Override
    public boolean updateSupplier(Supplier supplier) throws SQLException {
        for (int i = 0; i < suppliers.size(); i++) {
            if (suppliers.get(i).getId() == supplier.getId()) {
                suppliers.set(i, supplier);
                return true;
            }
        }
        return false;
    }

    @Override
    public boolean updateSupplierStatus(int supplierId, boolean isActive) throws SQLException {
        for (Supplier supplier : suppliers) {
            if (supplier.getId() == supplierId) {
                Supplier updated = new Supplier(
                    supplier.getId(),
                    supplier.getCompanyName(),
                    supplier.getContactName(),
                    supplier.getEmail(),
                    supplier.getPhone(),
                    supplier.getCity(),
                    supplier.getState(),
                    supplier.getPostalCode(),
                    supplier.getCountry(),
                    supplier.getSupplierType(),
                    isActive,
                    supplier.getLastUpdated()
                );
                suppliers.set(suppliers.indexOf(supplier), updated);
                return true;
            }
        }
        return false;
    }

    @Override
    public boolean deleteSupplier(int supplierId) throws SQLException {
        return suppliers.removeIf(s -> s.getId() == supplierId);
    }

    @Override
    public int getTotalSupplierCount() throws SQLException {
        return suppliers.size();
    }

    @Override
    public int getSupplierCountByType(String supplierType) throws SQLException {
        return (int) suppliers.stream()
                .filter(s -> s.getSupplierType().equalsIgnoreCase(supplierType))
                .count();
    }

    @Override
    public boolean isEmailExists(String email, int excludeId) throws SQLException {
        return suppliers.stream()
                .filter(s -> s.getId() != excludeId)
                .anyMatch(s -> s.getEmail().equalsIgnoreCase(email));
    }

    @Override
    public boolean isCompanyNameExists(String companyName, int excludeId) throws SQLException {
        return suppliers.stream()
                .filter(s -> s.getId() != excludeId)
                .anyMatch(s -> s.getCompanyName().equalsIgnoreCase(companyName));
    }
}
