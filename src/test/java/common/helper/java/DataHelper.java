package common.helper.java;

import resources.data.objects.Customer;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class DataHelper {

    private static ThreadLocal<Customer> customerThread = new ThreadLocal<Customer>();
    private static final DatabaseHelper dbHelper = new DatabaseHelper("test");

    public static List<Customer> getCustomers(List<Map<String, String>> dataset) {
        customerThread.set(new Customer());
        List<Customer> customers = new ArrayList<Customer>();
        for (int i = 0; i < dataset.size(); i++) {
            customerThread.get().setCustomerName(dataset.get(i).get("customerName"));
            customerThread.get().setCity(dataset.get(i).get("city"));
            customerThread.get().setCustomerNumber(dataset.get(i).get("customerNumber"));
            customerThread.get().setCountry(dataset.get(i).get("country"));
            customerThread.get().setPhone(dataset.get(i).get("phone"));
            customerThread.get().setAddressLine1(dataset.get(i).get("addressLine1"));
            customerThread.get().setAddressLine2(dataset.get(i).get("addressLine2"));
            customerThread.get().setContactFirstName(dataset.get(i).get("contactFirstName"));
            customerThread.get().setContactLastName(dataset.get(i).get("contactLastName"));
            customerThread.get().setCreditLimit(dataset.get(i).get("creditLimit"));
            customerThread.get().setPostalCode(dataset.get(i).get("postalCode"));
            customerThread.get().setSalesRepEmployeeNumber(dataset.get(i).get("salesRepEmployeeNumber"));
            customerThread.get().setState(dataset.get(i).get("state"));
            customers.add(customerThread.get());
        }
        return customers;
    }

    public static List<Map<String, String>> executeQuery(String query) {
        try {
            List<Map<String, String>> rs = dbHelper.executeQuery(query, DatabaseHelper.DatabaseType.MYSQL);
            return rs;
            //return getCustomers(rs).get(0);
        } catch (IndexOutOfBoundsException e) {
            return null;
        }
    }

    public static Map<String, String> getCustomerByNumber(String number) {
        String query = "select * " + "from customers " + "where customerNumber = '" + number + "'";
        try {
            List<Map<String, String>> rs = dbHelper.executeQuery(query, DatabaseHelper.DatabaseType.MYSQL);
            return rs.get(0);
            //return getCustomers(rs).get(0);
        } catch (IndexOutOfBoundsException e) {
            return null;
        }
    }
}