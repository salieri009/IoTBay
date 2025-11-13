package utils;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.util.Base64;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public final class PasswordUtil {

    private static final int SALT_LENGTH = 16;
    private static final int HASH_LENGTH = 32;
    private static final int ITERATIONS = 100000; // PBKDF2 iterations
    private static final String ALGORITHM = "PBKDF2WithHmacSHA256";
    private static final SecureRandom SECURE_RANDOM = new SecureRandom();

    private PasswordUtil() {}

    public static String hashPassword(String password) {
        if (!isValidPassword(password)) {
            throw new IllegalArgumentException("Password does not meet security requirements.");
        }

        byte[] salt = new byte[SALT_LENGTH];
        SECURE_RANDOM.nextBytes(salt);
        
        byte[] hash = pbkdf2(password.toCharArray(), salt, ITERATIONS, HASH_LENGTH);
        
        String saltBase64 = Base64.getEncoder().encodeToString(salt);
        String hashBase64 = Base64.getEncoder().encodeToString(hash);

        return saltBase64 + "$" + hashBase64;
    }

    public static boolean verifyPassword(String enteredPassword, String storedHash) {
        if (!isValidPassword(enteredPassword) || storedHash == null || storedHash.isEmpty()) {
            return false;
        }

        String[] parts = storedHash.split("\\$");
        if (parts.length != 2) {
            return false;
        }

        try {
            byte[] salt = Base64.getDecoder().decode(parts[0]);
            byte[] storedHashBytes = Base64.getDecoder().decode(parts[1]);
            
            byte[] enteredPasswordHash = pbkdf2(enteredPassword.toCharArray(), salt, ITERATIONS, HASH_LENGTH);
            
            return slowEquals(storedHashBytes, enteredPasswordHash);
        } catch (Exception e) {
            return false;
        }
    }

    private static byte[] pbkdf2(char[] password, byte[] salt, int iterations, int keyLength) {
        try {
            PBEKeySpec spec = new PBEKeySpec(password, salt, iterations, keyLength * 8);
            SecretKeyFactory skf = SecretKeyFactory.getInstance(ALGORITHM);
            return skf.generateSecret(spec).getEncoded();
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            throw new RuntimeException("Error generating password hash", e);
        }
    }

    private static boolean slowEquals(byte[] a, byte[] b) {
        int diff = a.length ^ b.length;
        for (int i = 0; i < a.length && i < b.length; i++) {
            diff |= a[i] ^ b[i];
        }
        return diff == 0;
    }

    private static boolean isValidPassword(String password) {
        if (password == null || password.length() < 8) {
            return false;
        }
        
        // Check for at least one uppercase, lowercase, digit, and special character
        boolean hasUpper = password.chars().anyMatch(Character::isUpperCase);
        boolean hasLower = password.chars().anyMatch(Character::isLowerCase);
        boolean hasDigit = password.chars().anyMatch(Character::isDigit);
        boolean hasSpecial = password.chars().anyMatch(ch -> "!@#$%^&*(),.?\":{}|<>".indexOf(ch) >= 0);
        
        return hasUpper && hasLower && hasDigit && hasSpecial;
    }
}