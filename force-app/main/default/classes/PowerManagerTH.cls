public with sharing class PowerManagerTH {
    public static void runAfterUpdate(List<Power_Manager__c> powerManagerRecords) {
        for (Power_Manager__c powerManagerRecord : powerManagerRecords) {
            if (powerManagerRecord.Status__c == 'Approved') {
                Id userId = powerManagerRecord.User__c;
                Id currentProfileId = powerManagerRecord.User__r.ProfileId;
                Id currentRoleId = powerManagerRecord.User__r.UserRoleId;
                Id newProfileId = PowerManagerTHelper.getProfileIdByName(powerManagerRecord.Profile__c);
                Id newRoleId = PowerManagerTHelper.getRoleIdByName(powerManagerRecord.Role__c);
                Id newPermissionSetId = PowerManagerTHelper.getPermissionSetIdByName(powerManagerRecord.Permission_Set__c);

                PowerManagerStartScheduler startPowerManagerSchedulerInstance = new PowerManagerStartScheduler(userId, powerManagerRecord.Id, currentProfileId, currentRoleId, newProfileId, newRoleId, newPermissionSetId);
                String startCronExpression = PowerManagerTHelper.convertDateTimeToCrone(powerManagerRecord.Start_Date__c);
                String startJobName = 'startJob' + powerManagerRecord.Id;
                System.schedule(startJobName, startCronExpression, startPowerManagerSchedulerInstance);

                PowerManagerStopScheduler endPowerManagerSchedulerInstance = new PowerManagerStopScheduler(powerManagerRecord, newPermissionSetId);
                String stopCronExpression = PowerManagerTHelper.convertDateTimeToCrone(powerManagerRecord.End_Date__c);
                String endJobName = 'endJob' + powerManagerRecord.Id;
                System.schedule(endJobName, stopCronExpression, endPowerManagerSchedulerInstance);
            }
        }
    }

    public static void runBeforeUpdate(List<Power_Manager__c> powerManagerRecords) {
        for (Power_Manager__c powerManagerRecord : powerManagerRecords) {
            if (powerManagerRecord.Status__c == 'Approved') {
                PowerManagerTHelper.updatePowerManagerRecordWithSerializedUserRecord(powerManagerRecord);
            }
        }
    }
}
