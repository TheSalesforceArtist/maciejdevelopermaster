/**
 * Created by Z02 on 8/2/2022.
 */

trigger AccountTrigger on Account (before insert, before update, after insert, after update) {
    /**
* Create a trigger that will
*   after insert:
*   Create a task and assign status new
*
*   before insert:
*    update the account with different industries depending on the first letter of Account Name
*
*   before update:
*   check if the industry is compliant with the naming convention. If so ok, if not throw an error
*
*   after update:
*   check if all tasks are completed. If not, throw error that all related tasks need to be completed
*   before saving the record
*
 **/
    Switch on trigger.operationType{
        when BEFORE_INSERT{
            for (Account currentAccount:trigger.new){
                currentAccount.Industry = AccountTriggerHandler.returnIndustry(String.valueOf(currentAccount.Name));
            }
        }

        when BEFORE_UPDATE{
            for (Account currentAccount:trigger.new){
                AccountTriggerHandler.industryChecker(currentAccount);
            }
        }

        when AFTER_INSERT{


            insert AccountTriggerHandler.createTasks(trigger.new);
        }

        when AFTER_UPDATE{
            for(Account currentAccount:Trigger.new){
                if (AccountTriggerHandler.taskChecker(currentAccount.Id)=='atLeastOneTaskIsNotCompleted'){
                    currentAccount.addError('You have at least one task that is not completed. Complete all tasks before making any updates');
                }
            }
        }

    }


}