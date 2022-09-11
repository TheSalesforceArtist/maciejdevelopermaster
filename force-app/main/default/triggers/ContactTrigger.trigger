/**
 * Created by Z02 on 8/3/2022.
 */

trigger ContactTrigger on Contact (before insert, before update, after insert, after update, before delete, after delete) {

    switch on Trigger.operationType{
        when AFTER_INSERT, AFTER_UPDATE{
            Boolean execut = trigger.isExecuting;
            system.debug('trigger execution '+execut);
            List<Account> accountsToUpdate = ContactTriggerHandler.accountsWithActiveContactLister(Trigger.new);
            update accountsToUpdate;
        }


    }
}