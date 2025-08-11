package security;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import model.User;

/**
 * 최신 트렌드: Token 기반 인증 (Simple Implementation)
 * Stateless Authentication with Custom Token
 */
public class TokenUtil {
    private static final String SECRET_KEY = "IoTBay_Secret_Key_2025_Super_Secure";
    private static final long EXPIRATION_TIME = 86400000; // 24 hours
    
    public static String generateToken(User user) {
        long currentTime = System.currentTimeMillis();
        long expirationTime = currentTime + EXPIRATION_TIME;
        
        String payload = user.getId() + ":" + user.getEmail() + ":" + user.getRole() + ":" + expirationTime;
        String signature = generateSignature(payload);
        
        return Base64.getEncoder().encodeToString((payload + ":" + signature).getBytes());
    }
    
    public static Map<String, String> extractTokenData(String token) {
        try {
            String decoded = new String(Base64.getDecoder().decode(token));
            String[] parts = decoded.split(":");
            
            if (parts.length >= 5) {
                Map<String, String> data = new HashMap<>();
                data.put("userId", parts[0]);
                data.put("email", parts[1]);
                data.put("role", parts[2]);
                data.put("expiration", parts[3]);
                data.put("signature", parts[4]);
                return data;
            }
        } catch (Exception e) {
            // Invalid token format
        }
        return null;
    }
    
    public static boolean isTokenExpired(String token) {
        Map<String, String> data = extractTokenData(token);
        if (data == null) return true;
        
        try {
            long expirationTime = Long.parseLong(data.get("expiration"));
            return System.currentTimeMillis() > expirationTime;
        } catch (NumberFormatException e) {
            return true;
        }
    }
    
    public static boolean validateToken(String token, String email) {
        Map<String, String> data = extractTokenData(token);
        if (data == null) return false;
        
        // Check email match
        if (!email.equals(data.get("email"))) return false;
        
        // Check expiration
        if (isTokenExpired(token)) return false;
        
        // Verify signature
        String payload = data.get("userId") + ":" + data.get("email") + ":" + 
                        data.get("role") + ":" + data.get("expiration");
        String expectedSignature = generateSignature(payload);
        
        return expectedSignature.equals(data.get("signature"));
    }
    
    private static String generateSignature(String payload) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            String dataToHash = payload + SECRET_KEY;
            byte[] hashBytes = md.digest(dataToHash.getBytes());
            return Base64.getEncoder().encodeToString(hashBytes);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 not available", e);
        }
    }
}
