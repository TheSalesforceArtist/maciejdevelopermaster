/**
 * Created by Z02 on 8/3/2022.
 */

public with sharing class UtilityService {

    public static void accountInserter(Integer NumberOfAccounts){
        List<Account> accountsToInsert = new List<Account>();
        for(Integer i=0;i<NumberOfAccounts;i++){
            Account acc = new Account(Name = UtilityService.randomStringMaxCharacters(20));
            accountsToInsert.add(acc);
        }
        insert accountsToInsert;
    }

    public static void contactInserter(Integer NumberOfContacts, Id AccountId, Boolean active){
        List<Contact> contactsToInsert = new List<Contact>();
        for(Integer i=0;i<NumberOfContacts;i++){
            Contact cont = new Contact(LastName = UtilityService.randomStringMaxCharacters(20), AccountId=AccountId, Active__c=active);
            contactsToInsert.add(cont);
        }
        insert contactsToInsert;
    }

    public static String randomStringMaxCharacters(Integer maxCharacters){
        Integer numOfCharacters;
        Integer letterNumber;
        String finalString;
        String currentLetter;
        do{
            numOfCharacters = Math.round(Math.random()*100);
        } while (numOfCharacters>maxCharacters);
        for (Integer i=0;i<numOfCharacters;i++){
            do{
                letterNumber = Math.round(Math.random()*100);
            } while (letterNumber>26);
            currentLetter=UtilityService.numberToLetterConvertor(letterNumber);
            if(finalString == null){
                finalString =currentLetter;
            }else{
                finalString = finalString+currentLetter;
            }
        }
        return finalString;
    }

    public static String numberToLetterConvertor(Integer letterNumber){
        String returnedLetter;
        if(letterNumber<=26){
            switch on letterNumber{
                when 1{
                    returnedLetter ='a';
                }
                when 2{
                    returnedLetter ='b';
                }
                when 3{
                    returnedLetter ='c';
                }
                when 4{
                    returnedLetter ='d';
                }
                when 5{
                    returnedLetter ='e';
                }
                when 6{
                    returnedLetter ='f';
                }
                when 7{
                    returnedLetter ='g';
                }
                when 8{
                    returnedLetter ='h';
                }
                when 9{
                    returnedLetter ='i';
                }
                when 10{
                    returnedLetter ='j';
                }
                when 11{
                    returnedLetter ='k';
                }
                when 12{
                    returnedLetter ='l';
                }
                when 13{
                    returnedLetter ='m';
                }
                when 14{
                    returnedLetter ='n';
                }
                when 15{
                    returnedLetter ='o';
                }
                when 16{
                    returnedLetter ='p';
                }
                when 17{
                    returnedLetter ='q';
                }
                when 18{
                    returnedLetter ='r';
                }
                when 19{
                    returnedLetter ='s';
                }
                when 20{
                    returnedLetter ='t';
                }
                when 21{
                    returnedLetter ='u';
                }
                when 22{
                    returnedLetter ='v';
                }
                when 23{
                    returnedLetter ='w';
                }
                when 24{
                    returnedLetter ='x';
                }
                when 25{
                    returnedLetter ='y';
                }
                when 26{
                    returnedLetter ='z';
                }
                when else{
                    returnedLetter =null;
                }
                
            }
        }
        return returnedLetter;
    }


}