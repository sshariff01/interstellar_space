require 'application_system_test_case'
require 'test_helper'

class ShopTest < ApplicationSystemTestCase
  test 'a merchant creates a new shop' do
    visit new_shop_url

    within('#new_shop') do
      assert_selector 'td#name', text: 'Shop Name'
      assert_selector 'td#description', text: 'Shop Description'
      assert_selector 'td#subdomain', text: 'Subdomain'

      fill_in 'shop_name', with: 'Funky Socks'
      fill_in 'shop_description', with: 'All the socks you could ever imagine, with the best designs you could ever imagine.'
      fill_in 'shop_subdomain', with: 'funky-socks'

      click_button 'create_shop'
    end
  end
end
