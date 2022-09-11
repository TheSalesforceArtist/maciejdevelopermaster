public with sharing class PowerManagerStartScheduler implements Schedulable {

    public Id userId;
    public Id powerManagerId;
    public Id currentProfileId;
    public Id currentRoleId;
    public Id newProfileId;
    public Id newRoleId;
    public Id newPermissionSet;

    public PowerManagerStartScheduler(Id parUserId, Id parPowerManagerId, Id parCurrentProfileId, Id parCurrentRoleId, Id parNewProfileId, Id parNewRoleId, Id parNewPermissionSet) {
        this.userId = parUserId;
        this.powerManagerId = parPowerManagerId;
        this.currentProfileId = parCurrentProfileId;
        this.currentRoleId = parCurrentRoleId;
        this.newProfileId = parNewProfileId;
        this.newRoleId = parNewRoleId;
        this.newPermissionSet = parNewPermissionSet;
    }

    public void execute(SchedulableContext sc) {
        User currentUser = [SELECT Id, UserRoleId, ProfileId FROM User WHERE Id = :this.userId][0];
        Boolean isChangedProfile = false;
        Boolean isChangedRole = false;
        Boolean isAddedPermissionSet = false;

        if (!String.isEmpty(String.valueOf(this.newProfileId)) && this.newProfileId != null) {
            isChangedProfile = true;
        }
        if (!String.isEmpty(String.valueOf(this.newRoleId)) && this.newRoleId != null) {
            isChangedRole = true;
        }
        if (PowerManagerSchedulerService.checkPermissionSetAssignmentExists(this.userId, this.newPermissionSet) != true &&
                !String.isEmpty(String.valueOf(this.newPermissionSet)) && !String.isBlank(String.valueOf(this.newPermissionSet))) {
            isAddedPermissionSet = true;
        }

        if (isChangedProfile == true) {
            currentUser.ProfileId = this.newProfileId;
        }
        if (isChangedRole == true) {
            currentUser.UserRoleId = this.newRoleId;
        }
        update currentUser;

        if (isAddedPermissionSet == true) {
            PermissionSetAssignment permissionSetAssignmentRecord = new PermissionSetAssignment(PermissionSetId = this.newPermissionSet, AssigneeId = this.userId);
            insert permissionSetAssignmentRecord;
        }
    }
}