require "application_system_test_case"

class OrganisationalUnitsTest < ApplicationSystemTestCase
  setup do
    @organisational_unit = organisational_units(:one)
  end

  test "visiting the index" do
    visit organisational_units_url
    assert_selector "h1", text: "Organisational Units"
  end

  test "creating a Organisational unit" do
    visit organisational_units_url
    click_on "New Organisational Unit"

    fill_in "Country", with: @organisational_unit.country
    fill_in "Geographic region", with: @organisational_unit.geographic_region
    fill_in "Name", with: @organisational_unit.name
    click_on "Create Organisational unit"

    assert_text "Organisational unit was successfully created"
    click_on "Back"
  end

  test "updating a Organisational unit" do
    visit organisational_units_url
    click_on "Edit", match: :first

    fill_in "Country", with: @organisational_unit.country
    fill_in "Geographic region", with: @organisational_unit.geographic_region
    fill_in "Name", with: @organisational_unit.name
    click_on "Update Organisational unit"

    assert_text "Organisational unit was successfully updated"
    click_on "Back"
  end

  test "destroying a Organisational unit" do
    visit organisational_units_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Organisational unit was successfully destroyed"
  end
end
