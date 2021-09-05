public class CommunityUserInfo {

    private static User user {
        get {
            if (user == null) {
                //TODO: init class field
            }

            return user;
        }
    }

    public static Id getUserId() {

        return UserInfo.getUserId();
    }

    public static Id getAccountId() {

        return user.AccountId;
    }

    public static Boolean isUserAdmin() {

        return null;
    }

    // ...

    public static User getUserRecord() {

        return user;
    }
}