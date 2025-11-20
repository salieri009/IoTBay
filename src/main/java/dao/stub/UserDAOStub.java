package dao.stub;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import dao.interfaces.UserDAO;
import model.User;

public class UserDAOStub implements UserDAO {
    private final List<User> users = new ArrayList<>();

    public UserDAOStub() {
        // Default test accounts as per README
        users.add(new User(1, "customer@iotbay.com", "password123", "Customer", "User", "+61 400 000 001", "2000", "1 George St", "Sydney NSW", LocalDate.of(1990, 1, 1), "Card", LocalDateTime.now(), LocalDateTime.now(), "customer", true));
        users.add(new User(2, "staff@iotbay.com", "staff123", "Staff", "User", "+61 400 000 002", "2001", "2 Pitt St", "Sydney NSW", LocalDate.of(1992, 5, 15), "PayPal", LocalDateTime.now(), LocalDateTime.now(), "staff", true));
        users.add(new User(5, "staff123@iotbay.com", "staff123", "Staff", "User", "+61 400 000 005", "2001", "2 Pitt St", "Sydney NSW", LocalDate.of(1992, 5, 15), "PayPal", LocalDateTime.now(), LocalDateTime.now(), "staff", true));
        
        // Test case 1-3: Basic users with different roles
        users.add(new User(3, "john.doe@example.com", "password123", "John", "Doe", "+61 400 000 003", "2000", "1 George St", "Sydney NSW", LocalDate.of(1990, 1, 1), "Card", LocalDateTime.now(), LocalDateTime.now(), "staff", true));
        users.add(new User(4, "jane.smith@example.com", "password456", "Jane", "Smith", "+61 400 000 004", "2001", "2 Pitt St", "Sydney NSW", LocalDate.of(1992, 5, 15), "PayPal", LocalDateTime.now(), LocalDateTime.now(), "customer", true));
        users.add(new User(6, "admin@iotbay.com", "admin123", "Admin", "User", "+61 400 000 006", "2000", "3 Market St", "Sydney NSW", LocalDate.of(1988, 3, 20), "Card", LocalDateTime.now(), LocalDateTime.now(), "admin", true));
        
        // Test case 4-6: Users with different contact details
        users.add(new User(7, "michael.johnson@test.com", "pass789", "Michael", "Johnson", "+61 400 000 007", "2100", "10 King St", "North Sydney NSW", LocalDate.of(1995, 7, 10), "PayPal", LocalDateTime.now(), LocalDateTime.now(), "customer", true));
        users.add(new User(8, "sarah.williams@test.com", "pass101", "Sarah", "Williams", "+61 400 000 008", "2010", "20 Oxford St", "Paddington NSW", LocalDate.of(1993, 11, 25), "Card", LocalDateTime.now(), LocalDateTime.now(), "customer", false));
        users.add(new User(9, "david.brown@test.com", "pass202", "David", "Brown", "+61 400 000 009", "2050", "30 Elizabeth St", "Redfern NSW", LocalDate.of(1991, 2, 14), "PayPal", LocalDateTime.now(), LocalDateTime.now(), "staff", true));
        
        // Test case 7-9: Users with edge case names
        users.add(new User(10, "robert.oconnor@test.com", "pass303", "Robert", "O'Connor", "+61 400 000 010", "2015", "40 Campbell St", "Haymarket NSW", LocalDate.of(1989, 6, 8), "Card", LocalDateTime.now(), LocalDateTime.now(), "customer", true));
        users.add(new User(11, "emily-garcia@test.com", "pass404", "Emily", "Garcia-Martinez", "+61 400 000 011", "2018", "50 Darling St", "Ultimo NSW", LocalDate.of(1994, 9, 22), "PayPal", LocalDateTime.now(), LocalDateTime.now(), "customer", true));
        users.add(new User(12, "timothy.lee@test.com", "pass505", "Timothy", "Lee", "+61 400 000 012", "2020", "60 Rawson St", "Erskineville NSW", LocalDate.of(1996, 12, 5), "Card", LocalDateTime.now(), LocalDateTime.now(), "staff", true));
        
        // Test case 10-12: Users with different postal codes and addresses
        users.add(new User(13, "jessica.clark@test.com", "pass606", "Jessica", "Clark", "+61 400 000 013", "2206", "70 Wellington St", "Wollongong NSW", LocalDate.of(1992, 4, 17), "PayPal", LocalDateTime.now(), LocalDateTime.now(), "customer", true));
        users.add(new User(14, "charles.taylor@test.com", "pass707", "Charles", "Taylor", "+61 400 000 014", "2261", "80 Edgeworth David St", "Edgeworth NSW", LocalDate.of(1987, 8, 30), "Card", LocalDateTime.now(), LocalDateTime.now(), "staff", false));
        users.add(new User(15, "louise.anderson@test.com", "pass808", "Louise", "Anderson", "+61 400 000 015", "2307", "90 Parry St", "Newcastle NSW", LocalDate.of(1990, 1, 19), "PayPal", LocalDateTime.now(), LocalDateTime.now(), "customer", true));
        
        // Test case 13-15: Users with inactive status
        users.add(new User(16, "marcus.williams@test.com", "pass909", "Marcus", "Williams", "+61 400 000 016", "2400", "100 Keira St", "Wollongong NSW", LocalDate.of(1988, 5, 9), "Card", LocalDateTime.now(), LocalDateTime.now(), "customer", false));
        users.add(new User(17, "rachel.harris@test.com", "pass010", "Rachel", "Harris", "+61 400 000 017", "2041", "110 Prince St", "Cronulla NSW", LocalDate.of(1993, 10, 11), "PayPal", LocalDateTime.now(), LocalDateTime.now(), "staff", false));
        users.add(new User(18, "steven.martin@test.com", "pass111", "Steven", "Martin", "+61 400 000 018", "2048", "120 Carrington Rd", "Coogee NSW", LocalDate.of(1985, 3, 23), "Card", LocalDateTime.now(), LocalDateTime.now(), "admin", true));
        
        // Test case 16-18: Users with special characters and international formats
        users.add(new User(19, "patricia.rodriguez@test.com", "pass212", "Patricia", "Rodriguez", "+61 400 000 019", "2112", "130 New South Head Rd", "Watsons Bay NSW", LocalDate.of(1991, 7, 6), "PayPal", LocalDateTime.now(), LocalDateTime.now(), "customer", true));
        users.add(new User(20, "kevin.thompson@test.com", "pass313", "Kevin", "Thompson", "+61 400 000 020", "2500", "140 Boomerang St", "Boomerang NSW", LocalDate.of(1989, 11, 14), "Card", LocalDateTime.now(), LocalDateTime.now(), "staff", true));
        users.add(new User(21, "amanda.white@test.com", "pass414", "Amanda", "White", "+61 400 000 021", "2515", "150 Cliff Rd", "Bundeena NSW", LocalDate.of(1994, 2, 28), "PayPal", LocalDateTime.now(), LocalDateTime.now(), "customer", true));
        
        // Test case 19-21: Users with various payment methods
        users.add(new User(22, "christopher.hall@test.com", "pass515", "Christopher", "Hall", "+61 400 000 022", "2522", "160 Ocean St", "Narrabeen NSW", LocalDate.of(1986, 9, 4), "Card", LocalDateTime.now(), LocalDateTime.now(), "customer", false));
        users.add(new User(23, "nicole.allen@test.com", "pass616", "Nicole", "Allen", "+61 400 000 023", "2531", "170 Gerringong St", "Gerringong NSW", LocalDate.of(1995, 6, 16), "PayPal", LocalDateTime.now(), LocalDateTime.now(), "staff", true));
        users.add(new User(24, "daniel.young@test.com", "pass717", "Daniel", "Young", "+61 400 000 024", "2540", "180 Crown St", "Wollongong NSW", LocalDate.of(1992, 12, 9), "Card", LocalDateTime.now(), LocalDateTime.now(), "customer", true));
    }

    @Override
    public void createUser(User user) throws SQLException {
        int newId = users.isEmpty() ? 1 : users.get(users.size() - 1).getId() + 1;
        User newUser = new User(
                newId,
                user.getEmail(),
                user.getPassword(),
                user.getFirstName(),
                user.getLastName(),
                user.getPhone(),
                user.getPostalCode(),
                user.getAddressLine1(),
                user.getAddressLine2(),
                user.getDateOfBirth(),
                user.getPaymentMethod(),
                LocalDateTime.now(),
                LocalDateTime.now(),
                user.getRole(),
                user.isActive()
        );
        users.add(newUser);
    }

    @Override
    public User getUserById(int id) throws SQLException {
        return users.stream()
                .filter(user -> user.getId() == id)
                .findFirst()
                .orElse(null);
    }

    @Override
    public List<User> getAllUsers() throws SQLException {
        return new ArrayList<>(users);
    }

    @Override
    public List<User> getUsersByEmail(String email) throws SQLException {
        return users.stream()
                .filter(user -> user.getEmail().contains(email))
                .collect(Collectors.toList());
    }

    @Override
    public User getUserByEmail(String email) throws SQLException {
        return users.stream()
                .filter(user -> user.getEmail().equals(email))
                .findFirst()
                .orElse(null);
    }

    @Override
    public boolean isEmailExists(String email) throws SQLException {
        return users.stream()
                .anyMatch(user -> user.getEmail().equals(email));
    }

    @Override
    public void updateUser(int id, User updatedUser) throws SQLException {
        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getId() == id) {
                users.set(i, new User(
                        id,
                        updatedUser.getEmail(),
                        updatedUser.getPassword(),
                        updatedUser.getFirstName(),
                        updatedUser.getLastName(),
                        updatedUser.getPhone(),
                        updatedUser.getPostalCode(),
                        updatedUser.getAddressLine1(),
                        updatedUser.getAddressLine2(),
                        updatedUser.getDateOfBirth(),
                        updatedUser.getPaymentMethod(),
                        users.get(i).getCreatedAt().toLocalDateTime(), // 기존 생성일 유지
                        LocalDateTime.now(), // 수정일 갱신
                        updatedUser.getRole(),
                        updatedUser.isActive()
                ));
                return;
            }
        }
    }

    @Override
    public void deleteUser(int id) throws SQLException {
        users.removeIf(user -> user.getId() == id);
    }

    @Override
    public int getTotalUserCount() throws SQLException {
        return users.size();
    }
}
