
public with sharing class Greetings {
    private String GoodMorning = 'Good Morning';
    private String GoodAfternoon = 'Good Afternoon';
    private String GoodEvening = 'Good Evening';


    public void printGoodMorning() {
        System.debug(GoodMorning);
    }

    public void printGoodAfternoon() {
        System.debug(GoodAfternoon);
    }

    public void printGoodEvening() {
        System.debug(GoodEvening);
    }

}