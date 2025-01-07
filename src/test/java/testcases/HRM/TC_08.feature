Feature: sample karate test script
for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

  Background:
    * startConfig("chrome")
    * def controls = locator('HRM', 'basepage')

  Scenario: Log in
    * driver 'https://opensource-demo.orangehrmlive.com/web/index.php/auth/login'
    * call HRM.login
    * call HRM.selectSideMenu {item: 'Leave'}
    * mouse(format(controls.topBarMenu, 'Leave List')).click()
    * mouse("//label[text()='Show Leave with Status']//parent::div//following-sibling::div//div[@class='oxd-select-text--after']").click()
    * def elements = locateAll("//div[@class='oxd-select-option']")
    * mouse("//label[text()='Show Leave with Status']//parent::div//following-sibling::div//div[@class='oxd-select-text--after']").click()
    * def result =
      """
        for(var i = 1; i <= karate.sizeOf(elements); i++){
          mouse("//label[text()='Show Leave with Status']//parent::div//following-sibling::div//div[@class='oxd-select-text--after']").click()
          mouse("//div[@class='oxd-select-option']["+1+"]").click()
        }
      """
    * delay(5000)


#    * def result =
#      """
#      function(){
#        var re = false
#        var from = new Date("02/08/2017").getTime();
#        var to = new Date("05/08/2026").getTime();
#        const regex = new RegExp('\\d{4}-\\d{1,2}-\\d{1,2}', 'g')
#        const str = `91.240.109.42FrancePrestashop PI block
#        2021-06-02 213.186.52.66FrancePrestaShop
#        2022-06-29`;
#        let m;
#        while ((m = regex.exec(str)) !== null) {
#          m.forEach((match) => {
#            var date = new Date(match);
#            var withinRange = date >= from && date <= to;
#            re = withinRange
#          });
#        }
#        return re;
#      }
#      """
#    * print result()


