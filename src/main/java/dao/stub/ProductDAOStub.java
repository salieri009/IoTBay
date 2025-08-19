package dao.stub;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import dao.interfaces.ProductDAO;
import model.Product;


public class ProductDAOStub implements ProductDAO {
    ArrayList<Product> products = new ArrayList<>();

    public ProductDAOStub() {
        // Adding some dummy products for testing
        products.add(new Product(1, 101, "Product 1", "Description 1", 10.0, 50, "image1.jpg", LocalDate.now()));
        products.add(new Product(2, 102, "Product 2", "Description 2", 20.0, 30, "image2.jpg", LocalDate.now()));
        products.add(new Product(3, 103, "Product 3", "Description 3", 30.0, 20, "image3.jpg", LocalDate.now()));
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
