/**
 * Created by Z02 on 5/19/2022.
 */
@IsTest
private class Covid19Test {

    @IsTest
    public static void shouldTestCovid19(){
        Covid19 testArea = new Covid19(10);
        Test.startTest();
        testArea.treatPatient();
        testArea.treatPatient();
        Covid19.printTreated('testArea');
        Integer treatedPatients = testArea.getTreated();
        Test.stopTest();


        System.assertEquals(12,Covid19.recoveredInCountry);
        System.assertEquals(12,treatedPatients);

    }


}