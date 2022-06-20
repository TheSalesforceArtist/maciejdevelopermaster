/**
 * Created by Z02 on 6/16/2022.
 */
@IsTest
private class FitnessTest {

    @IsTest
    private static void shouldTestCalculateBmi(){

        Decimal bodyWeight = 90.1;
        Decimal bodyHeight = 185;

        Decimal referenceBmi = BodyWeight/BodyHeight*10000;

        Test.startTest();
        Fitness testFitness = new Fitness();
        Decimal testBMI = testFitness.calculateBMI(bodyWeight, bodyHeight);
        Test.stopTest();

        System.assertEquals(referenceBmi,testBMI,'ReferenceBMI is not equal to testBMI');
    }

    @IsTest
    private static void shouldTestCalculatePace(){

        Decimal distance = 100;
        Integer walktime = 90;

        Decimal referencePace = distance/walktime;

        Test.startTest();
        Fitness testFitness = new Fitness();
        Decimal testPace = testFitness.calculatePace(distance, walktime);
        Test.stopTest();
    }
}