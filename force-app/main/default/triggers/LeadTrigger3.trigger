/**
 * Created by Z02 on 8/2/2022.
 */

trigger LeadTrigger3 on Lead (before insert, before update, after insert, after update) {
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            for (Lead leadRecord : Trigger.new) {
                if (String.isBlank(leadRecord.LeadSource)) {
                    leadRecord.LeadSource = 'Other';
                }
                // validation rules on Industry fields
                if (String.isBlank(leadRecord.Industry)) {
                    leadRecord.addError('The industry field cannot be blank');
                }
            }
        }

        when AFTER_INSERT {
            List<Task> tasksToInsert = new List<Task>();
            for (Lead leadRecord : Trigger.new) {
                // create a task
                Task leadTask = new Task(Subject = 'Follow up on Lead Status', WhoId = leadRecord.Id);
                tasksToInsert.add(leadTask);

            }
            insert tasksToInsert;

            Lead anotherLead = new Lead(LastName = 'Test Lead', Status='Open - Not Contacted', Company='ABC');
            insert anotherLead;

        }

        when BEFORE_UPDATE {
            for (Lead leadRecord : Trigger.new) {
                if (String.isBlank(leadRecord.LeadSource)) {
                    leadRecord.LeadSource = 'Other';
                }
                if ((leadRecord.Status == 'Closed - Converted' || leadRecord.Status == 'Closed - Not Converted') && Trigger.oldMap.get(leadRecord.Id).Status == 'Open - Not Contacted') {
                    leadRecord.Status.addError('You cannot directly close an open lead record');
                }
            }
        }
    }
}