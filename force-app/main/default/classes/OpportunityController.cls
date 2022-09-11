/**
 * Created by Z02 on 7/9/2022.
 */

public with sharing class OpportunityController {
    public static void updateProfileOnOpportunity (List<Id> OppIds){
        List<Opportunity> OppList = [SELECT Id, Amount, Profile__c FROM Opportunity WHERE Id IN :OppIds];
        for (Opportunity opp:OppList) {
            if(opp.Amount == null){
                opp.Profile__c = null;
            }
            else if (opp.Amount < 10000) {
                opp.Profile__c = 'Low';
            } else if (opp.Amount > 10000 && opp.Amount < 50000) {
                opp.Profile__c = 'Medium';
            } else {
                opp.Profile__c = 'High';
            }
        }
        update(OppList);
    }

    public static void clearProfileFieldOnOpportunity(List<Id>OppIds){
        List<Opportunity> OppList = [SELECT Id, Amount, Profile__c from Opportunity WHERE Id IN :OppIds];
        for (Opportunity opp:OppList) {
            opp.Profile__c = null;
        }
        update OppList;
    }

}