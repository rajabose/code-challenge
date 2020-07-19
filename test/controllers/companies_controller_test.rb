require "test_helper"
require "application_system_test_case"
require "mocha"
require 'mocha/test_unit'

class Zipcodes
  def self.identify
  end

  # def self.stub(identify)
  # end

end

class CompaniesControllerTest < ApplicationSystemTestCase

  def setup
    @company = companies(:hometown_painting)
    @address_details = { :city => "Atlanta", :state_code => "GA", :state_name => "Georgia", :timezone => "America/New_York" }
    @invalid_company = companies(:invalidate_company_details)
  end

  test "Index" do
    visit companies_path

    assert_text "Companies"
    assert_text "Hometown Painting"
    assert_text "Wolf Painting"
  end

  test "Show" do
    #I did not use the integration testing in rails erlier causing issue.
    # zipcodes = double('Zipcodes')
    #c = controller.class.const_get('Zipcodes')
    #allow(ZipCodes).to receive(:identify).and_return(@address_details)
    #Zipcodes.expects(:identify).returns(@address_details)
    Zipcodes.stub(:identify).returns(@address_details)
    # stub(ZipCodes, :identify => @address_details)
    #expect(ZipCodes).to receive(:identify).with(@address_details)
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    # assert_text @address_details.city
    # assert_text @address_details.state_name
    assert_text "City, State"
  end

  test "Should get zip code validation error" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "930097777")
      click_button "Update Company"
    end

    assert_text "should be valid, should be 12345 or 12345-1234"
  end

  test "Should get email validation error" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_email", with: "test@gmail.com")
      click_button "Update Company"
    end

    assert_text "must end with mainstreet.com"
  end

  test "Update" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "93009")
      click_button "Update Company"
    end

    assert_text "Changes Saved"

    @company.reload
    assert_equal "Updated Test Company", @company.name
    assert_equal "93009", @company.zip_code
  end

  test "Should get email and zip code validation error" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "281734346")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@test.com")
      click_button "Create Company"
    end

    assert_text "should be valid, should be 12345 or 12345-1234"
    assert_text "must end with mainstreet.com"
  end

  test "Create" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@mainstreet.com")
      click_button "Create Company"
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "New Test Company", last_company.name
    assert_equal "28173", last_company.zip_code
  end

  test "Destroy" do
    visit companies_path

    
  end
end
