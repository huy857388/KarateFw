Feature:
  Background:
    * def controls = locator('railway', 'loginpage')
    * def qr = "select %s from %s"
    * def qrWhere = qr + " where %s = '%s'"
    * def DatabaseHelper = Java.type("common.helper.java.DatabaseHelper")
    * def db = new DatabaseHelper("test")
    * def featurePath = feature('huytest','huytest','huytest')

  @methods
  Scenario:
    * print 'DEFAULT methods is load'
    * def selectAll = method(featurePath, '@selectAll')
    * def selectAllByCondition = method(featurePath, '@selectAllByCondition')
    * def insertARow = method(featurePath, '@insertARow')
    * def inputFromFile = method(featurePath, '@inputFromFile')
    * def cleanTable = method(featurePath, '@cleanTable')
    * def getDataType = method(featurePath, '@getDataType')
    * def createTable = method(featurePath, '@createTable')
    * def dropTable = method(featurePath, '@dropTable')
    * def writeFile = method(featurePath, '@writeFile')

  @selectAll
  Scenario:
    * def customer = db.executeQuery("select * " + "from " + tableName, DatabaseHelper.DatabaseType.MYSQL)
    * print customer

  @selectAllByCondition
  Scenario:
    * def qr = format(qrWhere, "productsample", condition, value)
    * def customer = db.executeQuery(qr, DatabaseHelper.DatabaseType.MYSQL)
    * print customer

  @insertARow
  Scenario:
    * def func =
      """
      function(arg){
        for(var i = 0; i < karate.sizeOf(mapUser); i++){
          var header = karate.toString(karate.keysOf(mapUser[i])).replaceAll('[', '').replaceAll(']', '')
          var value = karate.toString(karate.valuesOf(mapUser[i])).replaceAll('[', '').replaceAll(']','')
          var qr1 = "insert into " + tableName + " (" + header.replaceAll('"', '') + ") values (" + value.replaceAll('"', '\'') + ")"
          db.executeUpdate(qr1, DatabaseHelper.DatabaseType.MYSQL)
        }
      }
      """
    * eval func()

  @writeFile
  Scenario:
    * def table = karate.read('classpath:productsample.csv')
    * print karate.toCsv(table)
    * karate.write(karate.toCsv(table), '123.csv')

  @inputFromFile
  Scenario:
    * def tableObj = karate.read(filePath)
    * def insertARow = method(featurePath, '@insertARow')
    * def getDataType = method(featurePath, '@getDataType')
    * def listDataType = call getDataType {tableName: '#(tableName)'}
    * def func =
      """
      function(arg){
        for(var i = 0; i < karate.sizeOf(listDataType.output); i++){
          for(var j = 0; j < karate.sizeOf(tableObj); j++){
            if(listDataType.output[i].DATA_TYPE == 'date'){
              var key = Object.keys(tableObj[j])[i-1];
              if(listDataType.output[i].COLUMN_NAME == key){
                var date = Object.values(tableObj[j])[i-1]
                var mydate = new Date(Date.parse(date))
                var moth = mydate.getMonth() + 1
                tableObj[j][key] = mydate.getFullYear()+'-'+ moth +'-' + mydate.getDate()
              }
            }
          }
        }
      }
      """
    * eval func()
    * call insertARow {mapUser: '#(tableObj)', tableName: '#(tableName)'}

  @cleanTable
  Scenario:
    * def customer = db.executeUpdate("DELETE FROM productsample ", DatabaseHelper.DatabaseType.MYSQL)

  @getDataType
  Scenario:
    * def string = 123
    * def output = db.executeQuery("SELECT DATA_TYPE,COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '" + tableName + "'", DatabaseHelper.DatabaseType.MYSQL)
#    * def result = output[0]['DATA_TYPE']
#    * def func =
#    """
#    function(arg){
#    return typeof arg
#    }
#    """
#    * print func(string)

  @createTable
  Scenario:
    * def customer = db.executeUpdate("CREATE TABLE " + tableName + " (employee_id int AUTO_INCREMENT,first_name varchar(50) NOT NULL,last_name varchar(50) NOT NULL,email varchar(100) NOT NULL,hire_date date NOT NULL,salary DECIMAL(10,2) DEFAULT 0.00,department varchar(50), PRIMARY KEY (employee_id),UNIQUE (email));", DatabaseHelper.DatabaseType.MYSQL)

  @dropTable
  Scenario:
    * karate.log('dropTable')
    * def customer = db.executeUpdate("DROP TABLE " + tableName , DatabaseHelper.DatabaseType.MYSQL)


