require 'rails_helper'

describe "Specifications", js: true do
  it "User creates a new shop and is redirected to the newly created shop's home page" do
    visit site_root_path

    click_on 'Sign up'

    expect(page).to have_current_path(signup_merchant_path), "Unexpected URL.:\nExpected: #{new_merchant_path}\nGot: #{page.current_path}"

    within('#new_shop') do
      assert_selector 'td#name', text: 'Shop Name'
      assert_selector 'td#description', text: 'Shop Description'
      assert_selector 'td#subdomain', text: 'Subdomain'

      fill_in 'shop_name', with: 'Funky Socks'
      fill_in 'shop_description', with: 'All the socks you could ever imagine, with the best designs you could ever imagine.'
      fill_in 'shop_subdomain', with: 'funky-socks'

      click_on 'Create'
    end

    expect(page).to have_current_path('http://funky-socks.localhost:3002/', url: true), "Current page URL was #{page.current_url}"

    assert_selector 'h1', text: 'Funky Socks'
  end
end
