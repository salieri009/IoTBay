package dao.stub;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import dao.interfaces.ProductDAO;
import model.Product;


public class ProductDAOStub implements ProductDAO {
    ArrayList<Product> products = new ArrayList<>();

    public ProductDAOStub() {
        // Adding comprehensive dummy products for testing with 20+ test cases
        // Category 101: Smart Home Devices
        products.add(new Product(1, 101, "Smart Home Hub", "Central control hub for smart home automation", 199.99, 50, "image1.jpg", LocalDate.now()));
        products.add(new Product(2, 101, "Smart Light Bulb", "WiFi-enabled LED light bulb with color control", 24.99, 150, "image2.jpg", LocalDate.now()));
        products.add(new Product(3, 101, "Smart Thermostat", "Voice-controlled smart thermostat with learning capability", 149.99, 30, "image3.jpg", LocalDate.now()));
        products.add(new Product(4, 101, "Smart Door Lock", "Keyless entry system with mobile app control", 99.99, 45, "image4.jpg", LocalDate.now()));
        products.add(new Product(5, 101, "Smart Speaker", "High-quality audio with voice assistant integration", 79.99, 60, "image5.jpg", LocalDate.now()));
        
        // Category 102: Industrial Sensors
        products.add(new Product(6, 102, "Temperature Sensor", "Precise industrial-grade temperature measurement", 49.99, 80, "image6.jpg", LocalDate.now()));
        products.add(new Product(7, 102, "Humidity Sensor", "High-accuracy humidity and moisture detection", 39.99, 100, "image7.jpg", LocalDate.now()));
        products.add(new Product(8, 102, "Pressure Sensor", "Digital pressure measurement for industrial applications", 69.99, 40, "image8.jpg", LocalDate.now()));
        products.add(new Product(9, 102, "Motion Sensor", "PIR motion detection with adjustable sensitivity", 29.99, 120, "image9.jpg", LocalDate.now()));
        products.add(new Product(10, 102, "Distance Sensor", "Ultrasonic distance measurement sensor", 34.99, 90, "image10.jpg", LocalDate.now()));
        
        // Category 103: Microcontroller & Development Boards
        products.add(new Product(11, 103, "Arduino Uno", "Most popular microcontroller board for beginners", 19.99, 200, "image11.jpg", LocalDate.now()));
        products.add(new Product(12, 103, "Raspberry Pi 4", "Powerful single-board computer with 8GB RAM", 99.99, 75, "image12.jpg", LocalDate.now()));
        products.add(new Product(13, 103, "ESP8266 WiFi Module", "WiFi microcontroller with built-in connectivity", 9.99, 300, "image13.jpg", LocalDate.now()));
        products.add(new Product(14, 103, "Arduino Mega", "High-performance microcontroller with more pins", 29.99, 150, "image14.jpg", LocalDate.now()));
        products.add(new Product(15, 103, "STM32 Development Board", "ARM Cortex-M4 processor for advanced projects", 44.99, 60, "image15.jpg", LocalDate.now()));
        
        // Category 104: Connectivity & Networking
        products.add(new Product(16, 104, "4G LTE Module", "Industrial 4G LTE modem for remote connectivity", 129.99, 35, "image16.jpg", LocalDate.now()));
        products.add(new Product(17, 104, "LoRaWAN Gateway", "Long-range wide-area network gateway", 299.99, 20, "image17.jpg", LocalDate.now()));
        products.add(new Product(18, 104, "Bluetooth Module", "Low-energy Bluetooth connectivity module", 14.99, 200, "image18.jpg", LocalDate.now()));
        products.add(new Product(19, 104, "Ethernet Module", "Industrial-grade Ethernet connection adapter", 34.99, 80, "image19.jpg", LocalDate.now()));
        
        // Category 105: Power & Energy Management
        products.add(new Product(20, 105, "Solar Panel 100W", "High-efficiency photovoltaic solar panel", 399.99, 25, "image20.jpg", LocalDate.now()));
        products.add(new Product(21, 105, "Li-Po Battery 5000mAh", "Rechargeable lithium polymer battery pack", 29.99, 150, "image21.jpg", LocalDate.now()));
        products.add(new Product(22, 105, "DC Power Supply", "Regulated 12V/10A power supply unit", 49.99, 70, "image22.jpg", LocalDate.now()));
        products.add(new Product(23, 105, "USB-C Fast Charger", "Quick charge 65W USB-C power adapter", 39.99, 100, "image23.jpg", LocalDate.now()));
        
        // Out of stock product for testing
        products.add(new Product(24, 101, "Smart Blind Controller", "Motorized blind control system (Out of Stock)", 89.99, 0, "image24.jpg", LocalDate.now()));
        
        // Low stock product for testing
        products.add(new Product(25, 102, "Gas Sensor MQ-7", "Carbon monoxide detection sensor (Low Stock)", 19.99, 3, "image25.jpg", LocalDate.now()));
    }

    @Override
    public void createProduct(Product product) {
        products.add(product);
    }
    @Override
    public ArrayList<Product> getAllProducts() {
        return products;
    }
    @Override
    public Product getProductById(int id) {
        for (Product product : products) {
            if (product.getId() == id) {
                return product;
            }
        }
        return null;
    }
    @Override
    public ArrayList<Product> getProductsByName(String name) {
        ArrayList<Product> result = new ArrayList<>();
        for (Product product : products) {
            if (product.getName().toLowerCase().contains(name.toLowerCase())) {
                result.add(product);
            }
        }
        return result;
    }
    @Override
    public ArrayList<Product> getProductsByCategoryId(int categoryId) {
        ArrayList<Product> result = new ArrayList<>();
        for (Product product : products) {
            if (product.getCategoryId() == categoryId) {
                result.add(product);
            }
        }
        return result;
    }
    @Override
    public void updateProduct(int id, Product product) {
        for (int i = 0; i < products.size(); i++) {
            if (products.get(i).getId() == id) {
                products.set(i, product);
                return;
            }
        }
    }
    @Override
    public void deleteProduct(int id) {
        products.removeIf(product -> product.getId() == id);
    }

    public int countByCategory(int categoryId) {
        int count = 0;
        for (Product product : products) {
            if (product.getCategoryId() == categoryId) {
                count++;
            }
        }
        return count;
    }

    public int countByKeyword(String keyword) {
        int count = 0;
        String lowerKeyword = keyword.toLowerCase();
        for (Product product : products) {
            if (product.getName().toLowerCase().contains(lowerKeyword) ||
                product.getDescription().toLowerCase().contains(lowerKeyword)) {
                count++;
            }
        }
        return count;
    }

    public int countAll() {
        return products.size();
    }

    public ArrayList<Product> findByCategoryWithPagination(int categoryId, int offset, int limit) {
        ArrayList<Product> result = new ArrayList<>();
        ArrayList<Product> categoryProducts = getProductsByCategoryId(categoryId);
        
        int start = Math.min(offset, categoryProducts.size());
        int end = Math.min(offset + limit, categoryProducts.size());
        
        for (int i = start; i < end; i++) {
            result.add(categoryProducts.get(i));
        }
        
        return result;
    }

    public ArrayList<Product> searchWithPagination(String keyword, int offset, int limit) {
        ArrayList<Product> result = new ArrayList<>();
        ArrayList<Product> searchResults = getProductsByName(keyword);
        
        int start = Math.min(offset, searchResults.size());
        int end = Math.min(offset + limit, searchResults.size());
        
        for (int i = start; i < end; i++) {
            result.add(searchResults.get(i));
        }
        
        return result;
    }

    public ArrayList<Product> findWithPagination(int offset, int limit) {
        ArrayList<Product> result = new ArrayList<>();
        
        int start = Math.min(offset, products.size());
        int end = Math.min(offset + limit, products.size());
        
        for (int i = start; i < end; i++) {
            result.add(products.get(i));
        }
        
        return result;
    }

    public ArrayList<Product> findByStockAvailable() {
        ArrayList<Product> result = new ArrayList<>();
        for (Product product : products) {
            if (product.getStockQuantity() > 0) {
                result.add(product);
            }
        }
        return result;
    }

    @Override
    public int getTotalProductCount() throws SQLException {
        return products.size();
    }

    @Override
    public Product findById(int id) throws SQLException {
        return getProductById(id);
    }

    @Override
    public Product findById(Integer id) throws SQLException {
        return id != null ? getProductById(id) : null;
    }
}
