package services;

public class AuthenticationService {

    private PasswordService passwordService;
    private DatabaseService databaseService;

    public AuthenticationService(PasswordService passwordService, DatabaseService databaseService) {
        this.passwordService = passwordService;
        this.databaseService = databaseService;
    }

    /**
     * User info model
     */
    public static class UserInfo {
        public int id;
        public String username;
        public String email;
        public String firstName;
        public String lastName;
        public boolean isAdmin;
    }

    /**
     * Login result model
     */
    public static class LoginResult {
        public boolean success;
        public String message;
        public boolean isAdmin;
        public UserInfo user;

        public LoginResult(boolean success, String message, boolean isAdmin) {
            this.success = success;
            this.message = message;
            this.isAdmin = isAdmin;
        }
    }

    /**
     * Authenticate hardcoded admin
     */
    public LoginResult authenticateAdmin(String loginField, String password) {
        if ("ADMIN".equals(loginField) && "ADMIN@123".equals(password)) {
            UserInfo user = new UserInfo();
            user.id = 999;
            user.username = "ADMIN";
            user.email = "admin@oceanview.lk";
            user.firstName = "Admin";
            user.lastName = "User";
            user.isAdmin = true;

            LoginResult result = new LoginResult(true, "Admin login successful!", true);
            result.user = user;
            return result;
        }

        return new LoginResult(false, "Invalid credentials", false);
    }

    /**
     * Validate login credentials
     */
    public boolean validateCredentials(String loginField, String password) {
        return loginField != null && !loginField.isEmpty() && 
               password != null && !password.isEmpty();
    }
}
