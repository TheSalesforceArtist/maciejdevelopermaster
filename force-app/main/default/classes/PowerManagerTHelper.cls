public with sharing class PowerManagerTHelper {

    public static List<Profile> allCurrentProfiles = PowerManagerSelector.selectAllProfiles();
    public static List<UserRole> allCurrentRoles = PowerManagerSelector.selectAllRoles();
    public static List<PermissionSet> allCurrentPermissionsets = PowerManagerSelector.selectAllPermissionSets();

    public static String convertDateTimeToCrone(Datetime dateTimeValue) {
        String dateTimeExp = String.valueOf(dateTimeValue);
        String cronExpression;
        String seconds;
        String minutes;
        String hours;
        String dayOfMonth;
        String month;
        String year;
        if (dateTimeExp.right(2).left(1) == '0') {
            seconds = dateTimeExp.right(2);
        } else {
            seconds = dateTimeExp.right(1);
        }
        if (dateTimeExp.right(5).left(2).left(1) == '0') {
            minutes = dateTimeExp.right(5).left(2).right(1);
        } else {
            minutes = dateTimeExp.right(5).left(2).right(2);
        }
        if (dateTimeExp.right(8).left(2).left(1) == '0') {
            hours = dateTimeExp.right(8).left(2).right(1);
        } else {
            hours = dateTimeExp.right(8).left(2).right(2);
        }
        if (dateTimeExp.right(11).left(2).left(1) == '0') {
            dayOfMonth = dateTimeExp.right(11).left(2).right(1);
        } else {
            dayOfMonth = dateTimeExp.right(11).left(2).right(2);
        }
        if (dateTimeExp.right(14).left(2).left(1) == '0') {
            month = dateTimeExp.right(14).left(2).right(1);
        } else {
            month = dateTimeExp.right(14).left(2).right(2);
        }
        year = dateTimeExp.left(4);
        cronExpression = seconds + ' ' + minutes + ' ' + hours + ' ' + dayOfMonth + ' ' + month + ' ? ' + year;
        return cronExpression;
    }

    public static Id getProfileIdByName(String profileName) {
        Id currentProfileId;
        for (Profile currentProfile : allCurrentProfiles) {
            if (currentProfile.Name == profileName) {
                currentProfileId = currentProfile.Id;
            }
        }
        return currentProfileId;
    }

    public static Id getRoleIdByName(String roleName) {
        Id currentRoleId;
        for (UserRole currentRole : allCurrentRoles) {
            if (currentRole.Name == roleName) {
                currentRoleId = currentRole.Id;
            }
        }
        return currentRoleId;
    }

    public static Id getPermissionSetIdByName(String permissionSetName) {
        Id currentPermissionSetId;
        for (PermissionSet currentPermissionSet : allCurrentPermissionsets) {
            if (currentPermissionSet.Name == permissionSetName) {
                currentPermissionSetId = currentPermissionSet.Id;
            }
        }
        return currentPermissionSetId;
    }

    public static void updatePowerManagerRecordWithSerializedUserRecord(Power_Manager__c powerManagerRecord) {
        String serializedUser = PowerManagerSchedulerService.serializeUserRecord(powerManagerRecord.User__c);
        powerManagerRecord.Initial_User_Serialized__c = serializedUser;
    }

}