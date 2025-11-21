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
        LocalDateTime now = LocalDateTime.now();
        // Test case 1-3: Electronics suppliers
        suppliers.add(new Supplier(1, "John Smith", "TechCore Electronics", "john.smith@techcore.com", "+61 2 9876 5432", "123 Tech St", "", "Sydney", "NSW", "2000", "Australia", "www.techcore.com", "Electronics", true, now.minusDays(30), now.minusDays(30)));
        suppliers.add(new Supplier(2, "Sarah Johnson", "DigiParts Ltd", "sarah@digiparts.com.au", "+61 3 9876 5432", "456 Digital Ave", "", "Melbourne", "VIC", "3000", "Australia", "www.digiparts.com.au", "Electronics", true, now.minusDays(25), now.minusDays(25)));
        suppliers.add(new Supplier(3, "Michael Chen", "CircuitWorks Pty", "m.chen@circuitworks.com", "+61 7 9876 5432", "789 Circuit Rd", "", "Brisbane", "QLD", "4000", "Australia", "www.circuitworks.com", "Electronics", true, now.minusDays(20), now.minusDays(20)));

        // Test case 4-6: Sensor manufacturers
        suppliers.add(new Supplier(4, "Emma Wilson", "SensorTech Industries", "emma@sensortech.com.au", "+61 2 5555 5555", "321 Sensor Blvd", "", "Sydney", "NSW", "2015", "Australia", "www.sensortech.com.au", "Sensors", true, now.minusDays(28), now.minusDays(28)));
        suppliers.add(new Supplier(5, "David Lee", "Precision Sensors Inc", "david.lee@precisionsensors.com", "+61 8 4444 4444", "654 Precision Way", "", "Perth", "WA", "6000", "Australia", "www.precisionsensors.com", "Sensors", true, now.minusDays(22), now.minusDays(22)));
        suppliers.add(new Supplier(6, "Lisa Anderson", "MeasurePoint Solutions", "lisa@measurepoint.com", "+61 2 3333 3333", "987 Measure St", "", "Wollongong", "NSW", "2500", "Australia", "www.measurepoint.com", "Sensors", false, now.minusDays(18), now.minusDays(18)));

        // Test case 7-9: Microcontroller suppliers
        suppliers.add(new Supplier(7, "James Taylor", "MicroElectronix", "james@microelectronix.com.au", "+61 3 2222 2222", "147 Micro Lane", "", "Melbourne", "VIC", "3100", "Australia", "www.microelectronix.com.au", "Microcontrollers", true, now.minusDays(26), now.minusDays(26)));
        suppliers.add(new Supplier(8, "Rachel Brown", "ControlSystems Pro", "rachel@controlsys.com", "+61 7 1111 1111", "258 Control Ave", "", "Gold Coast", "QLD", "4217", "Australia", "www.controlsys.com", "Microcontrollers", true, now.minusDays(23), now.minusDays(23)));
        suppliers.add(new Supplier(9, "Peter Martinez", "EmbeddedCore Ltd", "peter@embeddedcore.com", "+61 2 6666 6666", "369 Embedded Dr", "", "Canberra", "ACT", "2601", "Australia", "www.embeddedcore.com", "Microcontrollers", true, now.minusDays(19), now.minusDays(19)));

        // Test case 10-12: Connectivity module suppliers
        suppliers.add(new Supplier(10, "Jennifer Davis", "ConnectTech Networks", "jen@connecttech.com.au", "+61 3 7777 7777", "741 Connect Rd", "", "Brisbane", "QLD", "4006", "Australia", "www.connecttech.com.au", "Connectivity", true, now.minusDays(27), now.minusDays(27)));
        suppliers.add(new Supplier(11, "Christopher Green", "WirelessParts Distributor", "chris@wirelessparts.com", "+61 2 8888 8888", "852 Wireless St", "", "Newcastle", "NSW", "2300", "Australia", "www.wirelessparts.com", "Connectivity", true, now.minusDays(24), now.minusDays(24)));
        suppliers.add(new Supplier(12, "Nicole Harris", "IoT Link Solutions", "nicole@iotlink.com.au", "+61 8 9999 9999", "963 IoT Blvd", "", "Adelaide", "SA", "5000", "Australia", "www.iotlink.com.au", "Connectivity", false, now.minusDays(21), now.minusDays(21)));

        // Test case 13-15: Power and energy suppliers
        suppliers.add(new Supplier(13, "Andrew White", "PowerSupply Corp", "andrew@powersupply.com", "+61 7 1010 1010", "159 Power Ave", "", "Toowoomba", "QLD", "4350", "Australia", "www.powersupply.com", "Power", true, now.minusDays(25), now.minusDays(25)));
        suppliers.add(new Supplier(14, "Victoria Clark", "EnergySource Distribution", "victoria@energysource.com.au", "+61 2 1111 1111", "357 Energy Way", "", "Penrith", "NSW", "2750", "Australia", "www.energysource.com.au", "Power", true, now.minusDays(20), now.minusDays(20)));
        suppliers.add(new Supplier(15, "Thomas Hill", "BatteryWorld Australia", "thomas@batteryworld.com", "+61 3 1212 1212", "468 Battery Dr", "", "Geelong", "VIC", "3220", "Australia", "www.batteryworld.com", "Power", true, now.minusDays(17), now.minusDays(17)));

        // Test case 16-18: Software and services
        suppliers.add(new Supplier(16, "Angela Martin", "SoftwareSolutions Aus", "angela@softwaresolutions.com.au", "+61 2 1313 1313", "579 Software St", "", "Chatswood", "NSW", "2067", "Australia", "www.softwaresolutions.com.au", "Software", true, now.minusDays(24), now.minusDays(24)));
        suppliers.add(new Supplier(17, "Robert Thompson", "ITServices Group", "robert@itservices.com", "+61 3 1414 1414", "680 IT Blvd", "", "Docklands", "VIC", "3008", "Australia", "www.itservices.com", "Software", true, now.minusDays(16), now.minusDays(16)));
        suppliers.add(new Supplier(18, "Sophie Jackson", "CloudTech Provider", "sophie@cloudtech.com.au", "+61 7 1515 1515", "791 Cloud Ave", "", "Fortitude Valley", "QLD", "4006", "Australia", "www.cloudtech.com.au", "Software", false, now.minusDays(14), now.minusDays(14)));

        // Test case 19-21: Inactive suppliers
        suppliers.add(new Supplier(19, "Mark Robinson", "LegacyElectronics Ltd", "mark@legacyelec.com", "+61 2 1616 1616", "802 Legacy Rd", "", "Parramatta", "NSW", "2150", "Australia", "www.legacyelec.com", "Electronics", false, now.minusDays(40), now.minusDays(40)));
        suppliers.add(new Supplier(20, "Karen Lewis", "OldTech Systems", "karen@oldtech.com.au", "+61 3 1717 1717", "913 Old St", "", "Brunswick", "VIC", "3056", "Australia", "www.oldtech.com.au", "Sensors", false, now.minusDays(35), now.minusDays(35)));
        suppliers.add(new Supplier(21, "George Walker", "DeprecatedParts Inc", "george@deprecatedparts.com", "+61 8 1818 1818", "124 Deprecated Way", "", "Fremantle", "WA", "6160", "Australia", "www.deprecatedparts.com", "Microcontrollers", false, now.minusDays(30), now.minusDays(30)));

        // Test case 22-24: International suppliers
        suppliers.add(new Supplier(22, "Wei Wong", "GlobalTech Singapore", "wei@globaltech.sg", "+65 6789 0123", "135 Global Ave", "", "Singapore", "SG", "018956", "Singapore", "www.globaltech.sg", "Electronics", true, now.minusDays(23), now.minusDays(23)));
        suppliers.add(new Supplier(23, "Priya Kumar", "AsianConnectivity Ltd", "priya@asianconn.in", "+91 22 1234 5678", "246 Asian Blvd", "", "Mumbai", "MH", "400001", "India", "www.asianconn.in", "Connectivity", true, now.minusDays(19), now.minusDays(19)));
        suppliers.add(new Supplier(24, "Klaus Mueller", "EuroElectronics GmbH", "klaus@euroelec.de", "+49 30 1234 5678", "357 Euro St", "", "Berlin", "Berlin", "10115", "Germany", "www.euroelec.de", "Electronics", true, now.minusDays(15), now.minusDays(15)));

        // Test case 25-27: Recently added suppliers
        suppliers.add(new Supplier(25, "Alex Johnson", "NewTech Startup", "alex@newtechstartup.com.au", "+61 2 2020 2020", "468 New Rd", "", "Surry Hills", "NSW", "2010", "Australia", "www.newtechstartup.com.au", "Electronics", true, now.minusDays(5), now.minusDays(5)));
        suppliers.add(new Supplier(26, "Bella Martinez", "InnovateSensor Corp", "bella@innovatesensor.com", "+61 3 2121 2121", "579 Innovate Way", "", "South Melbourne", "VIC", "3205", "Australia", "www.innovatesensor.com", "Sensors", true, now.minusDays(3), now.minusDays(3)));
        suppliers.add(new Supplier(27, "Daniel Scott", "FutureConnectivity Ltd", "daniel@futureconn.com.au", "+61 7 2222 2222", "680 Future Dr", "", "Spring Hill", "QLD", "4004", "Australia", "www.futureconn.com.au", "Connectivity", true, now.minusDays(1), now.minusDays(1)));

        // Test case 28-30: Mixed types and statuses
        suppliers.add(new Supplier(28, "Patricia Johnson", "Hybrid Solutions Aus", "patricia@hybridsolutions.com", "+61 2 2323 2323", "791 Hybrid Ave", "", "Macquarie Park", "NSW", "2113", "Australia", "www.hybridsolutions.com", "Power", true, now.minusDays(10), now.minusDays(10)));
        suppliers.add(new Supplier(29, "Richard Anderson", "SpecializedParts Ltd", "richard@specializedparts.com.au", "+61 3 2424 2424", "802 Special St", "", "Collingwood", "VIC", "3066", "Australia", "www.specializedparts.com.au", "Software", true, now.minusDays(8), now.minusDays(8)));
        suppliers.add(new Supplier(30, "Sandra King", "PremiumComponents Inc", "sandra@premiumcomp.com", "+61 8 2525 2525", "913 Premium Blvd", "", "East Perth", "WA", "6004", "Australia", "www.premiumcomp.com", "Electronics", false, now.minusDays(12), now.minusDays(12)));
    }

    private int getNextId() {
        return suppliers.isEmpty() ? 1 : suppliers.get(suppliers.size() - 1).getId() + 1;
    }

    @Override
    public Supplier createSupplier(Supplier supplier) throws SQLException {
        LocalDateTime now = LocalDateTime.now();
        Supplier newSupplier = new Supplier(
            getNextId(),
            supplier.getContactName(),
            supplier.getCompanyName(),
            supplier.getEmail(),
            supplier.getPhoneNumber(),
            supplier.getAddressLine1(),
            supplier.getAddressLine2() != null ? supplier.getAddressLine2() : "",
            supplier.getCity(),
            supplier.getState(),
            supplier.getPostalCode(),
            supplier.getCountry(),
            supplier.getWebsite() != null ? supplier.getWebsite() : "",
            supplier.getSupplierType(),
            supplier.isActive(),
            now,
            now
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
                LocalDateTime now = LocalDateTime.now();
                Supplier updated = new Supplier(
                    supplier.getId(),
                    supplier.getContactName(),
                    supplier.getCompanyName(),
                    supplier.getEmail(),
                    supplier.getPhoneNumber(),
                    supplier.getAddressLine1(),
                    supplier.getAddressLine2() != null ? supplier.getAddressLine2() : "",
                    supplier.getCity(),
                    supplier.getState(),
                    supplier.getPostalCode(),
                    supplier.getCountry(),
                    supplier.getWebsite() != null ? supplier.getWebsite() : "",
                    supplier.getSupplierType(),
                    isActive,
                    supplier.getCreatedAt(),
                    now
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
