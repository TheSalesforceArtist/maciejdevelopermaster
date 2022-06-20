public with sharing class Fitness {

    public Decimal calculateBMI(Decimal bodyWeight, Decimal bodyHeight) {
        Decimal exponant = 2;
        Decimal BMI = (bodyWeight / (bodyHeight*bodyHeight))*10000;
        System.debug('BMI ' + BMI);
        return BMI;
    }

    public Decimal calculatePace(Decimal distance, Integer walkTime) {
        Decimal pace = distance / walkTime;
        System.debug('Pace ' + pace);
        return pace;
    }


}