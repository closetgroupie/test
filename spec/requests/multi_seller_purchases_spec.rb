require 'spec_helper'

describe "MultiSellerPurchases" do
  before :each do
    Capybara.current_driver = :webkit
    @buyer = FactoryGirl.create(:user)
    @item1 = FactoryGirl.create(:item)
    @item2 = FactoryGirl.create(:item)
  end

  context "3 users: 2 sellers 1 buyer" do
    it "should create different orders for the different sellers" do
      visit 'https://developer.paypal.com'
      fill_in 'login_email', :with => 'tres@tspike.com'
      fill_in 'login_password', :with => '12345678'
      click_on 'Log In'

      binding.pry

      visit login_path
      binding.pry
      fill_in 'email', :with => @buyer.email
      fill_in 'password', :with => '12345678'
      click_on 'Login'
      page.should have_content 'Hi, TestUser'

      visit item_path(@item1)
      click_on 'Add to Cart'
      page.should have_content '1 Item in your cart'

      visit item_path(@item2)
      click_on 'Add to Cart'
      page.should have_content '2 Items in your cart'

      visit cart_path
      click_on 'Checkout'
      fill_in 'Full name of the person to ship to', :with => @buyer.name
      fill_in 'Street address', :with => '123 Whoreallycares Dr'
      fill_in 'City', :with => 'Crappyville'
      fill_in 'State or Region', :with => 'AR'
      fill_in 'Zip/Postal Code', :with => '66666'
      click_on 'Pay Now'
      save_and_open_page
    end
      
  end
end
