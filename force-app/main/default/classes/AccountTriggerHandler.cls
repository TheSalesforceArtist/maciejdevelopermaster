/**
 * Created by Z02 on 8/2/2022.
 */

public with sharing class AccountTriggerHandler {

    public static List<Task> createTasks(List<sObject> accountRecords){
        List<Task> relatedTasks = new list<Task>();
        for (Account currentAccount: (List<Account>) accountRecords){
            Task currentTask = new Task(WhatId=currentAccount.Id, Status='Not Started');
            relatedTasks.add(currentTask);
        }
        return relatedTasks;

    }

    public static String returnIndustry(String AccountName){
        String firstLetter = String.valueOf(AccountName.left(1));
        String industryName;
        Switch on firstLetter{
            when 'a'{
                industryName = 'Agriculture';
            }
            when 'b'{
                industryName = 'Banking';
            }
            when 'c'{
                industryName = 'Communications';
            }
            when 'e'{
                industryName = 'Education';
            }
            when 'f'{
                industryName = 'Finance';
            }
            when 'g'{
                industryName = 'Government';
            }
            when 'h'{
                industryName = 'Healthcare';
            }
            when 'i'{
                industryName = 'Insurance';
            }
            when 'm'{
                industryName = 'Manufacturing';
            }
            when 'r'{
                industryName = 'Recreation';
            }
            when 's'{
                industryName = 'Shipping';
            }
            when 't'{
                industryName = 'Technology';
            }
            when 'u'{
                industryName = 'Utilities';
            }
            when else{
                industryName ='Other';
            }

        }
        return industryName;
    }

    public static String taskChecker(Id AccountTd){
        List<Task> relatedTaskList =[SELECT Id, Status FROM Task WHERE WhatId=:AccountTd];
        String taskCheckerValue;
        if(!relatedTaskList.isEmpty()){
            taskCheckerValue = 'allTasksCompleted';
            for(Task currentTask:relatedTaskList){
                if(currentTask.Status != 'Completed'){
                    taskCheckerValue = 'atLeastOneTaskIsNotCompleted';
                }
            }
        }
        else{
            taskCheckerValue = 'noRelatedTasks';
        }
        return taskCheckerValue;

    }

    public static void industryChecker(Account acc){
        Account currentAccount = acc;
        if(currentAccount.Industry!=AccountTriggerHandler.returnIndustry(currentAccount.Name)){
            acc.addError('Selected industry is not compliant with naming convention');
        }
    }
}