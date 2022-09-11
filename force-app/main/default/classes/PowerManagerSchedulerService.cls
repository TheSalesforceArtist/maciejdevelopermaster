public with sharing class PowerManagerSchedulerService {

    public static PermissionSetAssignment findPermissionSetAssignment(id UserId, Id permissionSetId) {
        List<PermissionSetAssignment> PermissionSetAssignments = PowerManagerSelector.selectAllPermissionSetAssignments();
        PermissionSetAssignment targetPermissionSetAssignment = new PermissionSetAssignment();
        for (PermissionSetAssignment permissionSetAssignment : PermissionSetAssignments) {
            if (permissionSetAssignment.AssigneeId == UserId && permissionSetAssignment.PermissionSetId == permissionSetId) {
                targetPermissionSetAssignment = permissionSetAssignment;
            }
        }
        return targetPermissionSetAssignment;
    }

    public static Boolean checkPermissionSetAssignmentExists(Id userId, Id permissionSetId) {
        Boolean permissionSetAssignmentExists = false;
        List<PermissionSetAssignment> currentPermissionSetAssignments = PowerManagerSelector.selectAllPermissionSetAssignments();
        for (PermissionSetAssignment currentPermissionSetAssignment : currentPermissionSetAssignments) {
            if (currentPermissionSetAssignment.AssigneeId == userId && currentPermissionSetAssignment.PermissionSetId == permissionSetId) {
                permissionSetAssignmentExists = true;
            }
        }
        return permissionSetAssignmentExists;
    }

    public static String serializeUserRecord(Id userId) {
        User userToSerialize = PowerManagerSelector.selectUser(userId);
        String serializedUser = JSON.serializePretty(userToSerialize);
        return serializedUser;
    }

    public static User deserializeUserRecord(Power_Manager__c powerManagerRecord) {
        String userToDeserialize = powerManagerRecord.Initial_User_Serialized__c;
        User deserializedUser = (User) JSON.deserialize(userToDeserialize, User.class);
        return deserializedUser;
    }
}