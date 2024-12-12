Feature:

  Background:
    * def homePage = business('huytest', 'huytest')
    * def value = 1
    * def table = 'employees11'
    * def dataFile = 'classpath:productsample.csv'
    * def dataWriteFile = 'classpath:123.csv'
    * call homePage.createTable {tableName: '#(table)'}

    * configure afterScenario =
    """
    function(){
      karate.log('after scenarioss');
      karate.call(String(homePage.dropTable))
    }
    """

  Scenario:
#    * call homePage.insertARow {mapUser: '#(users)'}
#    * call homePage.inputFormFile
#    * call homePage.cleanTable
#    * call homePage.getDataType
#    * call homePage.createTable {tableName: '#(table)'}
    * call homePage.inputFromFile {filePath: '#(dataFile)', tableName: '#(table)'}
    * call homePage.selectAll {tableName: '#(table)'}




