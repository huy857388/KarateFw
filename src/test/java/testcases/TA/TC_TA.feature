Feature: sample karate test script
for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

  Background:
    * startConfig("chrome")
    * def controls = locator('HRM', 'basepage')

  Scenario: Log in
#    * driver 'https://paint.js.org/'
    * driver 'https://demo.testarchitect.com/'
    * waitForUrl('https://demo.testarchitect.com/')
    * scroll("//div[@class='elementor-image-carousel-wrapper swiper-container second-initialized swiper-container-initialized swiper-container-horizontal']")
#    * def logo = "//div[@class='elementor-image-carousel swiper-wrapper']"
#    * mouse("//div[@class='swiper-slide' and @data-swiper-slide-index='3']//img").down().move("//h2[text()='Subscribe to our newsletter!']").up().go()
#    * delay(50000)
#    * script("var dragStartEvent = new MouseEvent('dragstart', {bubbles: true, cancelable: true, view: window});")
#    * script("var dropEvent = new MouseEvent('drop', {bubbles: true, cancelable: true, view: window});")
#    * waitFor("//div[@class='swiper-slide' and @data-swiper-slide-index='3']//img").script("_.dispatchEvent(dragStartEvent)")
#    * script("//h2[text()='Subscribe to our newsletter!']", "_.dispatchEvent(dropEvent)")
#    * script("var myDragEvent = new Event('dragstart'); myDragEvent.dataTransfer = new DataTransfer()")
#    * waitFor("//div[@class='swiper-slide' and @data-swiper-slide-index='3']//img").script("_.dispatchEvent(myDragEvent)")
#    * script("var myDropEvent = new Event('drop'); myDropEvent.dataTransfer = myDragEvent.dataTransfer")
#    * script("//div[@class='swiper-slide' and @data-swiper-slide-index='2']//img", "_.dispatchEvent(myDropEvent)")
    * delay(5000)
    * def p = position("//div[@class='swiper-slide' and @data-swiper-slide-index='4']//img", true)
#    * mouse().move(parseInt(a), parseInt(b)).down().move(500, parseInt(b)).up()
    * mouse().move(parseInt(p['x']), parseInt(p['y'])).down().move(parseInt(p['x'] - p['width']/2), parseInt(p['y'])).up()
    * delay(5000)


