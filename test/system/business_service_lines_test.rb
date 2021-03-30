require "application_system_test_case"

class BusinessServiceLinesTest < ApplicationSystemTestCase
  setup do
    @business_service_line = business_service_lines(:one)
  end

  test "visiting the index" do
    visit business_service_lines_url
    assert_selector "h1", text: "Business Service Lines"
  end

  test "creating a Business service line" do
    visit business_service_lines_url
    click_on "New Business Service Line"

    fill_in "Name", with: @business_service_line.name
    fill_in "Organisational unit", with: @business_service_line.organisational_unit_id
    fill_in "Tier", with: @business_service_line.tier
    click_on "Create Business service line"

    assert_text "Business service line was successfully created"
    click_on "Back"
  end

  test "updating a Business service line" do
    visit business_service_lines_url
    click_on "Edit", match: :first

    fill_in "Name", with: @business_service_line.name
    fill_in "Organisational unit", with: @business_service_line.organisational_unit_id
    fill_in "Tier", with: @business_service_line.tier
    click_on "Update Business service line"

    assert_text "Business service line was successfully updated"
    click_on "Back"
  end

  test "destroying a Business service line" do
    visit business_service_lines_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Business service line was successfully destroyed"
  end
end
