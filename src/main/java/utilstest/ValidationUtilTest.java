package utilstest;

import org.junit.Test;

import utils.ValidationUtil;

import static org.junit.Assert.*;

/**
 * Test class for ValidationUtil
 */
public class ValidationUtilTest {

    // ═══════════════════════════════════════════════════════════════
    // LOGIN FIELD VALIDATION TESTS
    // ═══════════════════════════════════════════════════════════════

    @Test
    public void test1_ValidateLoginField_ValidInput() {
        System.out.println("\n╔════════════════════════════════════════════════════════╗");
        System.out.println("║  TEST 1: Login Field - Valid Input                   ║");
        System.out.println("╚════════════════════════════════════════════════════════╝");
        
        assertTrue("Valid login field should pass", 
                   ValidationUtil.isValidLoginField("testuser"));
        assertTrue("Valid login with numbers should pass", 
                   ValidationUtil.isValidLoginField("user123"));
        assertTrue("Valid login with special chars should pass", 
                   ValidationUtil.isValidLoginField("test_user"));
        
        System.out.println("✅ PASSED - Valid login fields accepted");
    }

    @Test
    public void test2_ValidateLoginField_InvalidInput() {
        System.out.println("\n╔════════════════════════════════════════════════════════╗");
        System.out.println("║  TEST 2: Login Field - Invalid Input                 ║");
        System.out.println("╚════════════════════════════════════════════════════════╝");
        
        assertFalse("Empty login field should fail", 
                    ValidationUtil.isValidLoginField(""));
        assertFalse("Whitespace only should fail", 
                    ValidationUtil.isValidLoginField("   "));
        assertFalse("Null login field should fail", 
                    ValidationUtil.isValidLoginField(null));
        
        System.out.println("✅ PASSED - Invalid login fields rejected");
    }

    // ═══════════════════════════════════════════════════════════════
    // PASSWORD VALIDATION TESTS
    // ═══════════════════════════════════════════════════════════════

    @Test
    public void test3_ValidatePassword_ValidInput() {
        System.out.println("\n╔════════════════════════════════════════════════════════╗");
        System.out.println("║  TEST 3: Password - Valid Input                      ║");
        System.out.println("╚════════════════════════════════════════════════════════╝");
        
        assertTrue("Valid password should pass", 
                   ValidationUtil.isValidPassword("password123"));
        assertTrue("Complex password should pass", 
                   ValidationUtil.isValidPassword("P@ssw0rd!#$"));
        assertTrue("Long password should pass", 
                   ValidationUtil.isValidPassword("MySecurePassword123456789"));
        
        System.out.println("✅ PASSED - Valid passwords accepted");
    }

    @Test
    public void test4_ValidatePassword_InvalidInput() {
        System.out.println("\n╔════════════════════════════════════════════════════════╗");
        System.out.println("║  TEST 4: Password - Invalid Input                    ║");
        System.out.println("╚════════════════════════════════════════════════════════╝");
        
        assertFalse("Empty password should fail", 
                    ValidationUtil.isValidPassword(""));
        assertFalse("Whitespace only should fail", 
                    ValidationUtil.isValidPassword("   "));
        assertFalse("Null password should fail", 
                    ValidationUtil.isValidPassword(null));
        
        System.out.println("✅ PASSED - Invalid passwords rejected");
    }

    // ═══════════════════════════════════════════════════════════════
    // EMAIL VALIDATION TESTS
    // ═══════════════════════════════════════════════════════════════

    @Test
    public void test5_ValidateEmail_ValidInput() {
        System.out.println("\n╔════════════════════════════════════════════════════════╗");
        System.out.println("║  TEST 5: Email - Valid Input                         ║");
        System.out.println("╚════════════════════════════════════════════════════════╝");
        
        assertTrue("Standard email should pass", 
                   ValidationUtil.isValidEmail("user@example.com"));
        assertTrue("Email with numbers should pass", 
                   ValidationUtil.isValidEmail("user123@example.com"));
        assertTrue("Email with subdomain should pass", 
                   ValidationUtil.isValidEmail("user@mail.example.com"));
        assertTrue("Email with hyphen should pass", 
                   ValidationUtil.isValidEmail("user-name@example.com"));
        
        System.out.println("✅ PASSED - Valid emails accepted");
    }

    @Test
    public void test6_ValidateEmail_InvalidInput() {
        System.out.println("\n╔════════════════════════════════════════════════════════╗");
        System.out.println("║  TEST 6: Email - Invalid Input                       ║");
        System.out.println("╚════════════════════════════════════════════════════════╝");
        
        assertFalse("Email without @ should fail", 
                    ValidationUtil.isValidEmail("userexample.com"));
        assertFalse("Email without domain should fail", 
                    ValidationUtil.isValidEmail("user@"));
        assertFalse("Email without extension should fail", 
                    ValidationUtil.isValidEmail("user@example"));
        assertFalse("Null email should fail", 
                    ValidationUtil.isValidEmail(null));
        assertFalse("Empty email should fail", 
                    ValidationUtil.isValidEmail(""));
        
        System.out.println("✅ PASSED - Invalid emails rejected");
    }

    // ═══════════════════════════════════════════════════════════════
    // USERNAME VALIDATION TESTS
    // ═══════════════════════════════════════════════════════════════

    @Test
    public void test7_ValidateUsername_ValidInput() {
        System.out.println("\n╔════════════════════════════════════════════════════════╗");
        System.out.println("║  TEST 7: Username - Valid Input                      ║");
        System.out.println("╚════════════════════════════════════════════════════════╝");
        
        assertTrue("3-char username should pass", 
                   ValidationUtil.isValidUsername("abc"));
        assertTrue("Username with numbers should pass", 
                   ValidationUtil.isValidUsername("user123"));
        assertTrue("Username with underscore should pass", 
                   ValidationUtil.isValidUsername("user_name"));
        assertTrue("Username with hyphen should pass", 
                   ValidationUtil.isValidUsername("user-name"));
        assertTrue("20-char username should pass", 
                   ValidationUtil.isValidUsername("abcdefghij1234567890"));
        
        System.out.println("✅ PASSED - Valid usernames accepted");
    }

    @Test
    public void test8_ValidateUsername_InvalidInput() {
        System.out.println("\n╔════════════════════════════════════════════════════════╗");
        System.out.println("║  TEST 8: Username - Invalid Input                    ║");
        System.out.println("╚════════════════════════════════════════════════════════╝");
        
        assertFalse("2-char username should fail (too short)", 
                    ValidationUtil.isValidUsername("ab"));
        assertFalse("21-char username should fail (too long)", 
                    ValidationUtil.isValidUsername("abcdefghij12345678901"));
        assertFalse("Username with spaces should fail", 
                    ValidationUtil.isValidUsername("user name"));
        assertFalse("Username with special chars should fail", 
                    ValidationUtil.isValidUsername("user@name"));
        assertFalse("Null username should fail", 
                    ValidationUtil.isValidUsername(null));
        
        System.out.println("✅ PASSED - Invalid usernames rejected");
    }

    // ═══════════════════════════════════════════════════════════════
    // PHONE NUMBER VALIDATION TESTS
    // ═══════════════════════════════════════════════════════════════

    @Test
    public void test9_ValidatePhoneNumber_ValidInput() {
        System.out.println("\n╔════════════════════════════════════════════════════════╗");
        System.out.println("║  TEST 9: Phone Number - Valid Input                  ║");
        System.out.println("╚════════════════════════════════════════════════════════╝");
        
        assertTrue("10-digit phone should pass", 
                   ValidationUtil.isValidPhoneNumber("0771234567"));
        assertTrue("Another 10-digit phone should pass", 
                   ValidationUtil.isValidPhoneNumber("0112345678"));
        
        System.out.println("✅ PASSED - Valid phone numbers accepted");
    }

    @Test
    public void test10_ValidatePhoneNumber_InvalidInput() {
        System.out.println("\n╔════════════════════════════════════════════════════════╗");
        System.out.println("║  TEST 10: Phone Number - Invalid Input               ║");
        System.out.println("╚════════════════════════════════════════════════════════╝");
        
        assertFalse("9-digit phone should fail", 
                    ValidationUtil.isValidPhoneNumber("077123456"));
        assertFalse("11-digit phone should fail", 
                    ValidationUtil.isValidPhoneNumber("07712345678"));
        assertFalse("Phone with letters should fail", 
                    ValidationUtil.isValidPhoneNumber("077ABC1234"));
        assertFalse("Null phone should fail", 
                    ValidationUtil.isValidPhoneNumber(null));
        
        System.out.println("✅ PASSED - Invalid phone numbers rejected");
    }

    // ═══════════════════════════════════════════════════════════════
    // URL VALIDATION TESTS
    // ═══════════════════════════════════════════════════════════════

    @Test
    public void test11_ValidateURL_ValidInput() {
        System.out.println("\n╔════════════════════════════════════════════════════════╗");
        System.out.println("║  TEST 11: URL - Valid Input                          ║");
        System.out.println("╚════════════════════════════════════════════════════════╝");
        
        assertTrue("Standard URL should pass", 
                   ValidationUtil.isValidURL("https://www.example.com"));
        assertTrue("URL without protocol should pass", 
                   ValidationUtil.isValidURL("www.example.com"));
        assertTrue("URL with path should pass", 
                   ValidationUtil.isValidURL("https://example.com/path/to/page"));
        
        System.out.println("✅ PASSED - Valid URLs accepted");
    }

    @Test
    public void test12_ValidateURL_InvalidInput() {
        System.out.println("\n╔════════════════════════════════════════════════════════╗");
        System.out.println("║  TEST 12: URL - Invalid Input                        ║");
        System.out.println("╚════════════════════════════════════════════════════════╝");
        
        assertFalse("URL without domain should fail", 
                    ValidationUtil.isValidURL("https://"));
        assertFalse("Null URL should fail", 
                    ValidationUtil.isValidURL(null));
        
        System.out.println("✅ PASSED - Invalid URLs rejected");
    }

    // ═══════════════════════════════════════════════════════════════
    // SANITIZE INPUT TESTS
    // ═══════════════════════════════════════════════════════════════

    @Test
    public void test13_SanitizeInput() {
        System.out.println("\n╔════════════════════════════════════════════════════════╗");
        System.out.println("║  TEST 13: Sanitize Input                             ║");
        System.out.println("╚════════════════════════════════════════════════════════╝");
        
        String input1 = "  TestUser  ";
        String result1 = ValidationUtil.sanitizeInput(input1);
        assertEquals("Input should be trimmed and lowercased", "testuser", result1);
        System.out.println("Input: '" + input1 + "' → Output: '" + result1 + "'");
        
        String input2 = "  ADMIN  ";
        String result2 = ValidationUtil.sanitizeInput(input2);
        assertEquals("Uppercase should be lowercased", "admin", result2);
        System.out.println("Input: '" + input2 + "' → Output: '" + result2 + "'");
        
        System.out.println("✅ PASSED - Input sanitized correctly");
    }

    // ═══════════════════════════════════════════════════════════════
    // CHARACTER TYPE VALIDATION TESTS
    // ═══════════════════════════════════════════════════════════════

    @Test
    public void test14_IsAlphabetic() {
        System.out.println("\n╔════════════════════════════════════════════════════════╗");
        System.out.println("║  TEST 14: Alphabetic Validation                      ║");
        System.out.println("╚════════════════════════════════════════════════════════╝");
        
        assertTrue("Letters only should pass", 
                   ValidationUtil.isAlphabetic("abcABC"));
        assertFalse("Letters with numbers should fail", 
                    ValidationUtil.isAlphabetic("abc123"));
        assertFalse("Empty string should fail", 
                    ValidationUtil.isAlphabetic(""));
        
        System.out.println("✅ PASSED - Alphabetic validation works");
    }

    @Test
    public void test15_IsNumeric() {
        System.out.println("\n╔════════════════════════════════════════════════════════╗");
        System.out.println("║  TEST 15: Numeric Validation                         ║");
        System.out.println("╚════════════════════════════════════════════════════════╝");
        
        assertTrue("Numbers only should pass", 
                   ValidationUtil.isNumeric("123456"));
        assertFalse("Numbers with letters should fail", 
                    ValidationUtil.isNumeric("123abc"));
        assertFalse("Empty string should fail", 
                    ValidationUtil.isNumeric(""));
        
        System.out.println("✅ PASSED - Numeric validation works");
    }

    @Test
    public void test16_IsAlphanumeric() {
        System.out.println("\n╔════════════════════════════════════════════════════════╗");
        System.out.println("║  TEST 16: Alphanumeric Validation                    ║");
        System.out.println("╚════════════════════════════════════════════════════════╝");
        
        assertTrue("Letters and numbers should pass", 
                   ValidationUtil.isAlphanumeric("abc123"));
        assertFalse("Special chars should fail", 
                    ValidationUtil.isAlphanumeric("abc@123"));
        assertFalse("Spaces should fail", 
                    ValidationUtil.isAlphanumeric("abc 123"));
        
        System.out.println("✅ PASSED - Alphanumeric validation works");
    }

    // ═══════════════════════════════════════════════════════════════
    // LENGTH VALIDATION TESTS
    // ═══════════════════════════════════════════════════════════════

    @Test
    public void test17_ValidateMinLength() {
        System.out.println("\n╔════════════════════════════════════════════════════════╗");
        System.out.println("║  TEST 17: Minimum Length Validation                  ║");
        System.out.println("╚════════════════════════════════════════════════════════╝");
        
        assertTrue("Length >= min should pass", 
                   ValidationUtil.isValidMinLength("password", 5));
        assertFalse("Length < min should fail", 
                    ValidationUtil.isValidMinLength("pass", 5));
        assertFalse("Null should fail", 
                    ValidationUtil.isValidMinLength(null, 5));
        
        System.out.println("✅ PASSED - Minimum length validation works");
    }

    @Test
    public void test18_ValidateMaxLength() {
        System.out.println("\n╔════════════════════════════════════════════════════════╗");
        System.out.println("║  TEST 18: Maximum Length Validation                  ║");
        System.out.println("╚════════════════════════════════════════════════════════╝");
        
        assertTrue("Length <= max should pass", 
                   ValidationUtil.isValidMaxLength("pass", 10));
        assertFalse("Length > max should fail", 
                    ValidationUtil.isValidMaxLength("password123456", 10));
        assertFalse("Null should fail", 
                    ValidationUtil.isValidMaxLength(null, 10));
        
        System.out.println("✅ PASSED - Maximum length validation works");
    }

    @Test
    public void test19_ValidateLengthRange() {
        System.out.println("\n╔════════════════════════════════════════════════════════╗");
        System.out.println("║  TEST 19: Length Range Validation                    ║");
        System.out.println("╚════════════════════════════════════════════════════════╝");
        
        assertTrue("Length in range should pass", 
                   ValidationUtil.isValidLengthRange("password", 5, 15));
        assertFalse("Length below range should fail", 
                    ValidationUtil.isValidLengthRange("pass", 5, 15));
        assertFalse("Length above range should fail", 
                    ValidationUtil.isValidLengthRange("passwordtoolong", 5, 10));
        assertFalse("Null should fail", 
                    ValidationUtil.isValidLengthRange(null, 5, 15));
        
        System.out.println("✅ PASSED - Length range validation works");
    }
}
