package utils;

import static org.junit.Assert.*;
import org.junit.Test;

/**
 * Unit tests for PasswordUtil
 * Tests password hashing and verification
 */
public class PasswordUtilTest {
    
    @Test
    public void testPasswordHashing() {
        String password = "TestPassword123!";
        String hash = PasswordUtil.hashPassword(password);
        
        assertNotNull("Hash should not be null", hash);
        assertTrue("Hash should contain separator", hash.contains("$"));
        assertNotEquals("Hash should be different from password", password, hash);
    }
    
    @Test
    public void testPasswordVerification() {
        String password = "TestPassword123!";
        String hash = PasswordUtil.hashPassword(password);
        
        assertTrue("Correct password should verify", 
                PasswordUtil.verifyPassword(password, hash));
        assertFalse("Wrong password should not verify", 
                PasswordUtil.verifyPassword("WrongPassword123!", hash));
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void testWeakPasswordRejection() {
        String weakPassword = "weak";
        PasswordUtil.hashPassword(weakPassword);
    }
    
    @Test
    public void testDifferentPasswordsProduceDifferentHashes() {
        String password = "TestPassword123!";
        String hash1 = PasswordUtil.hashPassword(password);
        String hash2 = PasswordUtil.hashPassword(password);
        
        // Hashes should be different due to salt
        assertNotEquals("Same password should produce different hashes (due to salt)", 
                hash1, hash2);
        
        // But both should verify
        assertTrue("First hash should verify", 
                PasswordUtil.verifyPassword(password, hash1));
        assertTrue("Second hash should verify", 
                PasswordUtil.verifyPassword(password, hash2));
    }
}

