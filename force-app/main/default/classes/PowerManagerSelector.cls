/**
 * Created by Z02 on 8/24/2022.
 */

public with sharing class PowerManagerSelector {

    public static List<Profile> selectAllProfiles() {
        return [
                SELECT
                        Id,
                        Name
                FROM Profile
        ];
    }

    public static List<UserRole> selectAllRoles() {
        return [
                SELECT
                        Id,
                        Name
                FROM UserRole
        ];
    }

    public static List<PermissionSet> selectAllPermissionSets() {
        return [
                SELECT
                        Id,
                        Name
                FROM PermissionSet
        ];
    }

    public static List<PermissionSetAssignment> selectAllPermissionSetAssignments(){
        return [
                SELECT
                        Id,
                        PermissionSetId,
                        AssigneeId
                FROM PermissionSetAssignment
        ];
    }

    public static User selectUser(Id userId){
        return [
                SELECT
                        Id,
                        UserRoleId,
                        ProfileId
                FROM User
                WHERE
                        Id=:userId
        ];
    }

    public static Power_Manager__c selectPowerManagerRecord(Id powerManagerRecordId){
        return [
                SELECT
                        Id,
                        OwnerId,
                        IsDeleted,
                        Name,
                        CreatedDate,
                        CreatedById,
                        LastModifiedDate,
                        LastModifiedById,
                        SystemModstamp,
                        LastActivityDate,
                        LastViewedDate,
                        LastReferencedDate,
                        User__c,
                        Profile__c,
                        Role__c,
                        Permission_Set__c,
                        Start_Date__c,
                        End_Date__c,
                        Existing_Profile__c,
                        Existing_Role__c,
                        Reason_for_Request__c,
                        Initial_User_Serialized__c
                FROM
                        Power_Manager__c
                WHERE
                        Id=:powerManagerRecordId
        ];
    }
}