require 'rails_helper'

describe "Specifications" do
  before(:each) do
    @merchant = Merchant.create(
      :name => 'Socks Company',
      :email => 'jakob@socks.co',
      :password => 's0m3Passw0rd',
    )
  end

  it "Merchant can register" do
    visit site_root_path

    click_on 'Sign up'

    expect(page).to have_current_path(signup_merchant_path), "Unexpected path:\nExpected: #{new_merchant_path}, but got: #{page.current_path}"

    within('#new_merchant') do
      assert_selector 'td#name', text: 'Name'
      assert_selector 'td#email', text: 'Email'
      assert_selector 'td#password', text: 'Password'
      assert_selector 'td#password-confirmation', text: 'Confirm Password'

      fill_in 'merchant_name', with: 'Socks Co.'
      fill_in 'merchant_email', with: 'thesockcompany@email.com'
      fill_in 'merchant_password', with: 'Sockscompany1'
      fill_in 'merchant_password_confirmation', with: 'Sockscompany1'

      click_on 'Sign Up'
    end

    assert_selector 'h1', text: 'Socks Co. Dashboard'
  end

  it "Merchant can log in and create a shop" do
    visit site_root_path

    click_on 'Login'

    expect(page).to have_current_path(login_merchant_path), "Unexpected path:\nExpected: #{login_merchant_path}, but got: #{page.current_path}"

    within('#new_session') do
      assert_selector 'td#email', text: 'Email'
      assert_selector 'td#password', text: 'Password'

      fill_in 'email', with: 'jakob@socks.co'
      fill_in 'password', with: 's0m3Passw0rd'

      click_on 'Login'
    end

    assert_selector 'h1', text: 'Socks Company Dashboard'

    click_on 'Sign up'

    within('#new_shop') do
      assert_selector 'td#name', text: 'Shop Name'
      assert_selector 'td#description', text: 'Shop Description'
      assert_selector 'td#subdomain', text: 'Subdomain'

      fill_in 'shop_name', with: 'Fuzzy Feet'
      fill_in 'shop_description', with: 'Fuzzy covers for all your feet!'
      fill_in 'shop_subdomain', with: 'fuzzy-feet-23'

      click_on 'Create'
    end

    expect(current_subdomain).to eq('fuzzy-feet-23')
  end

  def current_subdomain
    page.current_url.match(/^.*\/\/(.[^\.]+)\..+$/).captures.last
  end
end
