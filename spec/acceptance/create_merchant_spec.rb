require 'rails_helper'

describe "Specifications" do
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
end
