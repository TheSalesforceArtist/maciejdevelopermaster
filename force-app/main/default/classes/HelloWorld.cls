public with sharing class HelloWorld {
    private String greeting = 'Hello World';
    // public variable
    public String publicGreeting = 'public Hello World';

    public void printGreeting() {
        System.debug(greeting);
    }

    // get an error about access modifiers:
    // global void printPublicGreeting() {
    //      System.debug(publicGreeting);
    // }
}