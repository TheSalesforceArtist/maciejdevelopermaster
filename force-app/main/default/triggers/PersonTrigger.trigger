/**
 * Created by Z02 on 8/17/2022.
 */

trigger PersonTrigger on Person__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    switch on Trigger.operationType{
        when BEFORE_INSERT{
            PersonTriggerHandler.checkHealthStatusGreen(Trigger.new);
            PersonTriggerHandler.checkPersonMobileEmpty(Trigger.new);
            PersonTriggerHandler.updateTokenOnPersonList(Trigger.new);
            }
        when BEFORE_UPDATE{
           PersonTriggerHandler.updateStatusUpdateDateFieldOnStatusChange(Trigger.newMap, Trigger.oldMap, Trigger.new);



        }
    }
}
