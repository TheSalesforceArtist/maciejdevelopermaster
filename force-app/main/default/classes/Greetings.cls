public with sharing class Greetings  {
    private String GoodMorning = 'Good Morning';
    private String GoodAfternoon = 'Good Afternoon';
    private String GoodEvening = 'Good Evening';


    private void printGoodMorning() {
        System.debug(GoodMorning);
    }

    private void printGoodAfternoon() {
        System.debug(GoodAfternoon);
    }

    private void printGoodEvening() {
        System.debug(GoodEvening);
    }
    public void displayDayPeriod(String PeriodOfDay){

        Switch on PeriodOfDay{
            when 'Morning'{
                new Greetings().printGoodMorning();
            }
            when 'Afternoon' {
                new Greetings().printGoodAfternoon();
            }
            when 'Evening'{
                this.printGoodEvening();
            }
            when else{
                system.debug('Invalid period of the day');
            }
        }
    }

    public void displayDayPeriod(){

        List<String> periodList = new list<String>{GoodMorning,GoodAfternoon,GoodEvening};
                for (String period:periodList){
            system.debug(period);
        }
    }
}