/**
 * Created by Z02 on 7/26/2022.
 */

trigger LeadTrigger2 on Lead (before insert, before update, after update, after insert) {
    System.debug('Trigger size: '+ Trigger.size);
    System.debug('is Trigger'+ Trigger.isExecuting);
    System.debug('Operation type: '+ Trigger.operationType);
    if(Trigger.isUpdate){
        for(Lead currentLead:Trigger.new){
            if((currentLead.Status=='Closed - Converted'||currentLead.Status=='Closed - Not Converted')&& Trigger.oldMap.get(currentLead.id).Status == 'Open - Not Contacted'){
                currentLead.addError('You cannot set a lead to a closed Status from Open - Not Contacted Status');
            }
        }

    }
    if(Trigger.isInsert){
        for(Lead currentLead:Trigger.new){
            if(currentLead.Status=='Closed - Converted'||currentLead.Status=='Closed - Not Converted'){
                currentLead.addError('You cannot set a lead to a closed Status directly. Please work a bit on it damn it !');
            }
        }

    }

}