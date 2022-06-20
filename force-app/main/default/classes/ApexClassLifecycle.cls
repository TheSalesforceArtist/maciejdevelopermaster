/**
 * Created by Z02 on 5/26/2022.
 */

public with sharing class ApexClassLifecycle {
    public ApexClassLifecycle(){
        System.debug('Calling ApexClassLifecycle empty constructor');
    }

    public ApexClassLifecycle(Integer X){
        System.debug('Calling ApexLifecycle constructor with parameter X equals '+X);
    }

    public ApexClassLifecycle(Integer x, String y){
        this();
        System.debug('Calling ApexLifecycle constructor with parameter X equals '+X+' and Y equals '+Y);
    }

    {
        System.debug('Calling initialization block');
    }

    static{
        System.debug('Calling static initialization block');
    }
}