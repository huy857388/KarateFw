Feature:

  Scenario:
    # * def customer = dataHelper.getCustomerByNumber('103')
    * def customer = dataHelper.executeQuery("select * " + "from customers " + "where customerNumber = '" + "103" + "'")
    * print customer[0].country
    * match customer contains {"country":"France","city":"Nantes","contactFirstName":"Carine ","postalCode":"44000","salesRepEmployeeNumber":"1370","customerNumber":"103","customerName":"Atelier graphique","phone":"40.32.2555","addressLine1":"54, rue Royale","creditLimit":"21000.00","contactLastName":"Schmitt","addressLine2":null,"state":null}