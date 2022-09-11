public with sharing class PowerManagerStopScheduler implements Schedulable {
    public Power_Manager__c powerManagerRecord;
    public Id newPermissionSetId;

    public PowerManagerStopScheduler(Power_Manager__c parPowerManagerRecord, Id parNewPermissionSetId) {
        this.powerManagerRecord = parPowerManagerRecord;
        this.newPermissionSetId = parNewPermissionSetId;
    }

    public void execute(SchedulableContext sc) {
        User userToUpdate = PowerManagerSchedulerService.deserializeUserRecord(this.powerManagerRecord);
        update userToUpdate;
        PermissionSetAssignment permissionSetAssignmentToDelete = PowerManagerSchedulerService.findPermissionSetAssignment(powerManagerRecord.User__c, newPermissionSetId);
        if (permissionSetAssignmentToDelete != null) {
            delete permissionSetAssignmentToDelete;
        }
    }
}