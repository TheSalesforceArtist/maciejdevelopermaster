/**
 * Created by Z02 on 5/29/2022.
 */

public with sharing class CompanyClass {

    public String companyName;
    public String ceo;
    public Integer employeeCount;
    public Long revenue;

    //List of all customers
    private List<Client> customers = new List<Client>();
    //add new customer
    @Deprecated
    public void addNewCustomer(String clientName, String website, String email, Long phone) {
        Client customer = new Client(clientName, website, email, phone);
        customers.add(customer);
    }


    //print the list of all customers
    public void getAllCustomers() {
        //to do ; print all customers
        for (Client customer : customers) {
            System.debug('Customer Name: ' + customer.clientName + ', Website: ' + customer.website + ', Email: ' + customer.email + ', Phone: ' + customer.phone);
        }
    }
    //private inner class to store the customer information

    private class Client {
        public String clientName;
        public String website;
        public String email;
        public Long phone;

        //Constructor to initialize the values
        Client(String clientName, String website, String email, Long phone) {
            this.clientName = clientName;
            this.website = website;
            this.email = email;
            this.phone = phone;
        }
    }
}