package utils;

/**
 * Utility class for input validation
 */
public class ValidationUtil {

    /**
     * Validate login field - checks if not empty
     * @param loginField The login field to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidLoginField(String loginField) {
        return loginField != null && !loginField.trim().isEmpty();
    }

    /**
     * Validate password - checks if not empty
     * @param password The password to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidPassword(String password) {
        return password != null && !password.trim().isEmpty();
    }

    /**
     * Validate email format using regex
     * @param email The email to validate
     * @return true if valid email format, false otherwise
     */
    public static boolean isValidEmail(String email) {
        if (email == null) return false;
        
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
        return email.matches(emailRegex);
    }

    /**
     * Validate username - length 3-20, alphanumeric with underscore/hyphen
     * @param username The username to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidUsername(String username) {
        if (username == null || username.length() < 3 || username.length() > 20) {
            return false;
        }
        return username.matches("^[a-zA-Z0-9_-]+$");
    }

    /**
     * Validate phone number - 10 digits
     * @param phoneNumber The phone number to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidPhoneNumber(String phoneNumber) {
        if (phoneNumber == null) return false;
        return phoneNumber.matches("^[0-9]{10}$");
    }

    /**
     * Validate URL format
     * @param url The URL to validate
     * @return true if valid URL, false otherwise
     */
    public static boolean isValidURL(String url) {
        if (url == null) return false;
        
        String urlRegex = "^(https?://)?([\\w-]+\\.)+[\\w-]+(:\\d+)?(/.*)?$";
        return url.matches(urlRegex);
    }

    /**
     * Sanitize input - trim and lowercase
     * @param input The input to sanitize
     * @return sanitized string
     */
    public static String sanitizeInput(String input) {
        if (input == null) return null;
        return input.trim().toLowerCase();
    }

    /**
     * Check if string contains only letters
     * @param text The text to check
     * @return true if only letters, false otherwise
     */
    public static boolean isAlphabetic(String text) {
        if (text == null || text.isEmpty()) return false;
        return text.matches("^[a-zA-Z]+$");
    }

    /**
     * Check if string contains only numbers
     * @param text The text to check
     * @return true if only numbers, false otherwise
     */
    public static boolean isNumeric(String text) {
        if (text == null || text.isEmpty()) return false;
        return text.matches("^[0-9]+$");
    }

    /**
     * Check if string contains only alphanumeric characters
     * @param text The text to check
     * @return true if only alphanumeric, false otherwise
     */
    public static boolean isAlphanumeric(String text) {
        if (text == null || text.isEmpty()) return false;
        return text.matches("^[a-zA-Z0-9]+$");
    }

    /**
     * Validate minimum length
     * @param text The text to validate
     * @param minLength Minimum required length
     * @return true if length >= minLength, false otherwise
     */
    public static boolean isValidMinLength(String text, int minLength) {
        return text != null && text.length() >= minLength;
    }

    /**
     * Validate maximum length
     * @param text The text to validate
     * @param maxLength Maximum allowed length
     * @return true if length <= maxLength, false otherwise
     */
    public static boolean isValidMaxLength(String text, int maxLength) {
        return text != null && text.length() <= maxLength;
    }

    /**
     * Validate length range
     * @param text The text to validate
     * @param minLength Minimum required length
     * @param maxLength Maximum allowed length
     * @return true if minLength <= length <= maxLength, false otherwise
     */
    public static boolean isValidLengthRange(String text, int minLength, int maxLength) {
        return text != null && text.length() >= minLength && text.length() <= maxLength;
    }
}
