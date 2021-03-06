require 'rails_helper'

describe "Specifications" do
  before(:each) do
    @merchant = Merchant.create(
      :name => 'Socks Company',
      :email => 'jakob@socks.co',
      :password => 's0m3Passw0rd',
    )
  end

  context "Merchant is not registered" do
    it "Merchant can register and log out" do
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

      click_on 'Logout'

      expect(page).to have_current_path(site_root_path), "Unexpected path:\nExpected: #{site_root_path}, but got: #{page.current_path}"

      assert_no_selector '#logout'
      assert_selector '#login', text: 'Login'
      assert_selector '#signup', text: 'Signup'
    end

    it "Merchant must register with a valid password (i.e. password must be at least eight characters, contain at least one uppercase letter, one lowercase letter, and one number)" do
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
        fill_in 'merchant_password', with: 'socks1company'
        fill_in 'merchant_password_confirmation', with: 'socks1company'

        click_on 'Sign Up'
      end

      expect(page).to have_current_path(register_merchant_path), "Unexpected path:\nExpected: #{new_merchant_path}, but got: #{page.current_path}"

      assert_selector '.errors li', text: 'Password must be at least eight characters, contain at least one uppercase letter, one lowercase letter, and one number'
    end
  end

  context "Merchant is logged in" do
    before(:each) do
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
    end

    it "Merchant can create a shop" do
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

    it "Merchant can navigate to dashboard from any screen" do
      click_on 'Dashboard'

      assert_selector 'h1', text: 'Socks Company Dashboard'
    end
  end

  def current_subdomain
    page.current_url.match(/^.*\/\/(.[^\.]+)\..+$/).captures.last
  end
end
