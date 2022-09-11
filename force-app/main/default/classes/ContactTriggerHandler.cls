/**
 * Created by Z02 on 8/3/2022.
 */

public with sharing class ContactTriggerHandler {

    public static List<Account> accountsWithActiveContactLister(List<Contact> contactsFromTrigger){
        Map<Id, Integer> accountIdsWithContactNumberMap = ContactTriggerHandler.countActiveContactsPerAccount(contactsFromTrigger);
        system.debug('countActiveContactsPerAccount '+accountIdsWithContactNumberMap);
        List<Account> accountsToUpdateWithActiveContactNumber = ContactTriggerHandler.accountsWithActiveContacts(accountIdsWithContactNumberMap);
        system.debug('accountsToUpdateWithActiveContactNumber '+accountsToUpdateWithActiveContactNumber);
        return accountsToUpdateWithActiveContactNumber;
    }

    public static Map<Id, Integer> countActiveContactsPerAccount(List<Contact> contacts){
        system.debug('what shit happens In countActiveContactsPerAccount ?');
        Integer activeContactsCount;
        Set<Id> relatedAccountIds = new Set<Id>();
        for(Contact currentContact:contacts){
            relatedAccountIds.add(currentContact.AccountId);
        }
        system.debug('set relatedAccountIds '+relatedAccountIds);

        List<Contact> activeContacts = [SELECT Id, Active__c, AccountId
                                        FROM Contact
                                        WHERE AccountId IN :relatedAccountIds
                                        AND Active__c = TRUE];
        system.debug('list  activeContacts '+activeContacts);
        Map<Id,Integer> accountsWithActiveContactsCountMap = new Map<Id,Integer>();
        List<Contact> activeContactsPerAccount = new list<Contact>();
        for(Id relatedAccountId:relatedAccountIds){
            for(Contact activeContact:activeContacts){
                if(activeContact.AccountId==relatedAccountId){
                    activeContactsPerAccount.add(activeContact);
                }
            }
            if(activeContactsPerAccount.size()==0 || activeContactsPerAccount.isEmpty()==true){
                activeContactsCount = 0;
            }else{
                activeContactsCount = activeContactsPerAccount.size();
            }
            system.debug('activeContactsCount '+activeContactsCount);
            accountsWithActiveContactsCountMap.put(relatedAccountId, activeContactsCount);
            activeContactsPerAccount.clear();
            activeContactsCount = null;
        }

        return accountsWithActiveContactsCountMap;
    }

    public static List<Account> accountsWithActiveContacts(Map<Id, Integer>accountsWithActiveContactsCount){
        List<Account> accountsToUpdate = new List<Account>();
        for(Id key:accountsWithActiveContactsCount.keySet()){
            Account acc = new Account(Id=key, Active_Contacts__c=accountsWithActiveContactsCount.get(key));
            accountsToUpdate.add(acc);

        }
        return accountsToUpdate;
    }
}