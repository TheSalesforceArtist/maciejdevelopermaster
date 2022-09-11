/**
 * Created by Z02 on 7/21/2022.
 */

trigger leadtrigger on Lead (before insert,after insert, before update, after update) {
    for(Lead currentLead:Trigger.new){
        //if(String.isBlank(currentLead.LeadSource)){
        if(trigger.isBefore){
            currentLead.leadSource = 'Other';}
        //}
        if(String.isBlank(currentLead.Industry) && Trigger.isInsert){
            //sObject.addError('You cannot leave this field blank you silly motherfucker');
            currentLead.addError('You cannot leave this field blank you silly motherfucker');
        }
    }
}