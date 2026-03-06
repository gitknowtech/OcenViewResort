package services;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

public class PasswordService {

    /**
     * Hash password using SHA-256
     */
    public String hashPassword(String password) throws Exception {
        if (password == null || password.isEmpty()) {
            throw new IllegalArgumentException("Password cannot be null or empty");
        }
        
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
        
        StringBuilder sb = new StringBuilder();
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) sb.append('0');
            sb.append(hex);
        }
        return sb.toString();
    }

    /**
     * Verify password against hash
     */
    public boolean verifyPassword(String password, String hash) throws Exception {
        if (password == null || hash == null) {
            return false;
        }
        String hashedInput = hashPassword(password);
        return hashedInput.equals(hash);
    }

    /**
     * Check if password is strong
     */
    public boolean isStrongPassword(String password) {
        if (password == null || password.length() < 8) {
            return false;
        }
        
        boolean hasUppercase = password.matches(".*[A-Z].*");
        boolean hasLowercase = password.matches(".*[a-z].*");
        boolean hasDigit = password.matches(".*\\d.*");
        
        return hasUppercase && hasLowercase && hasDigit;
    }
}
