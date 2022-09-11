trigger PowerManagerTrigger on Power_Manager__c (after update, before update) {
    switch on Trigger.operationType {
        when BEFORE_UPDATE{
            PowerManagerTH.runBeforeUpdate(Trigger.new);

        }
        when AFTER_UPDATE{
            PowerManagerTH.runAfterUpdate(Trigger.new);

        }
    }
}