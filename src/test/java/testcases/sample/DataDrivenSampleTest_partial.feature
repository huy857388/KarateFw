Feature: Data Driven Sample Test
  Background:
#    * startConfig('chrome_local')
#    * def appData = data('tademostoreweb', 'app')
#    * def homePage = locator('tademostoreweb', 'basepage')
#    * def shopPage = locator('tademostoreweb', 'shoppage')

  Scenario:
    # Step 1: Go to homepage
#    * driver appData.url

#    # Step 2: Select menu Shop
#    * call tademostoreweb.selectTopMenu {menu: 'Shop'}
#
#    # VP: SHOP page is shown
#    * waitFor(shopPage.closeAdPopupButton)
#    * click(shopPage.closeAdPopupButton)
#    * match getURL() == appData.shopURL
#    * match exists(shopPage.shopLabel) == true

    # Step 3: In Shop page, click on "cart" icon to add a product to cart
    # VP: Cart icon number at the top right of shopping page is increased correctly
    * table products
      | productName                      | name   | age |
      | "AirPods"                        | { baz: 1 }   | 2   |
      | "Beats Solo3 Wireless On-Ear"    | 'Wild' | 4   |
      | "Beats Studio Wireless Over-Ear" | 'Nyan' | 3   |

#    * call tademostoreweb.addProductToCart products
    * print products[0]['name']['baz']
