/**
 * Created by Z02 on 6/22/2022.
 */

public with sharing class AccountController {

    public static List<Account> insertAccountList(List<Account> accountsToInsert) {
        insert accountsToInsert;
        return accountsToInsert;
    }

    public static Account insertAccount(Account accountToInsert) {
        insert accountToInsert;
        return accountToInsert;
    }

    public static List<Account> deleteAccounts(List<Account> accountsToDelete) {
        try {
            delete accountsToDelete;

        } catch (exception e) {
            system.debug('Delete operation failed with following exception code ' + e);
        }
        return accountsToDelete;
    }

    public static Account deleteAccount(Account accountToDelete) {
        try {
            delete accountToDelete;
        } catch (exception e) {
            system.debug('Delete operation failed with following exception code ' + e);
        }
        return accountToDelete;
    }

    public static List<Account> updateAccounts(List<Account> accountsToUpdate) {
        try {
            update accountsToUpdate;
        } catch (exception e) {
            system.debug('Update operation failed with following exception code ' + e);
        }
        return accountsToUpdate;
    }

    public static Account updateAccount(Account accountToUpdate) {
        try {
            update accountToUpdate;
        } catch (exception e) {
            system.debug('Delete operation failed with following exception code ' + e);
        }
        return accountToUpdate;
    }

    public static List<Account> getExistingAccounts(String field1) {
        String accountStringQuery = 'SELECT ' + field1 + ' FROM ACCOUNT';
        List<Account> Accounts = Database.query(accountStringQuery);
        AccountController.displayListOfAccounts(Accounts);
        Return Accounts;
    }

    public static List<Account> getExistingAccounts(String field1, String field2) {
        String accountStringQuery = 'SELECT ' + field1 + ',' + field2 + ' FROM ACCOUNT';
        List<Account> Accounts = Database.query(accountStringQuery);
        AccountController.displayListOfAccounts(Accounts);
        Return Accounts;
    }

    public static List<Account> getExistingAccounts(String field1, String field2, String field3) {
        String accountStringQuery = 'SELECT ' + field1 + ',' + field2 + ',' + field3 + ' FROM ACCOUNT';
        List<Account> Accounts = Database.query(accountStringQuery);
        AccountController.displayListOfAccounts(Accounts);
        Return Accounts;
    }

    public static List<Account> getExistingAccounts(String field1, String field2, String field3, String field4) {
        String accountStringQuery = 'SELECT ' + field1 + ',' + field2 + ',' + field3 + ',' + field4 + ' FROM ACCOUNT';
        List<Account> Accounts = Database.query(accountStringQuery);
        AccountController.displayListOfAccounts(Accounts);
        Return Accounts;
    }

    public static List<Account> getExistingAccounts(String field1, String field2, String field3, String field4, String field5) {
        String accountStringQuery = 'SELECT ' + field1 + ',' + field2 + ',' + field3 + ',' + field4 + ',' + field5 + ' FROM ACCOUNT';
        List<Account> Accounts = Database.query(accountStringQuery);
        AccountController.displayListOfAccounts(Accounts);
        Return Accounts;
    }

    public static List<Account> getExistingAccounts(String field1, String field2, String field3, String field4, String field5, String field6) {
        String accountStringQuery = 'SELECT ' + field1 + ',' + field2 + ',' + field3 + ',' + field4 + ',' + field5 + ',' + field6 + ' FROM ACCOUNT';
        List<Account> Accounts = Database.query(accountStringQuery);
        AccountController.displayListOfAccounts(Accounts);
        Return Accounts;
    }

    public static void DisplayListOfAccounts(List<Account>accounts) {
        for (Account singleAccount : accounts) {
            System.debug(singleAccount);
        }
    }

    public static void updateAvgCaseResolutionDays(List<Id> accountIds) {
        List<Case> relatedCasesList = [SELECT  Id, AccountId, CreatedDate, ClosedDate
                                FROM Case
                                WHERE IsClosed = TRUE
                                AND AccountId =: accountIds];
        if(!relatedCasesList.isEmpty()) {
            List<Account> accountsToUpdate = new List<Account>();
            List<Id> accountIdsWithCases = new List<Id>();
            Map<Id, List<Case>> relatedCasesMap = new Map<Id, List<Case>>();
            for (Case relatedCase : relatedCasesList) {
                if (!relatedCasesMap.containsKey(relatedCase.AccountId)) {
                    relatedCasesMap.put(relatedCase.AccountId, new List<Case>());
                }
                relatedCasesMap.get(relatedCase.AccountId).add(relatedCase);
                if(!accountIdsWithCases.contains(relatedCase.AccountId)){
                    accountIdsWithCases.add(relatedCase.AccountId);
                }

            }
            for (Id accountIdWithCase : accountIdsWithCases) {
                Integer totalDays = 0, totalCases = 0;
                List<Case> currentCasesList = relatedCasesMap.get(accountIdWithCase);
                if (!currentCasesList.isEmpty()) {
                    for (Case currentCase : currentCasesList) {
                        totalCases++;
                        totalDays += currentCase.CreatedDate.date().daysBetween(currentCase.ClosedDate.date());
                    }
                    Decimal resolutionDays = totalDays / totalCases;
                        Account accountToUpdate = new Account(Id = accountIdWithCase, Avg_Case_Resolution_Days__c = resolutionDays);
                    accountsToUpdate.add(accountToUpdate);
                }
            }
                update accountsToUpdate;
            }
        }

    }

//}