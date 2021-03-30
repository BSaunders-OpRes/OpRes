require 'test_helper'

class OrganisationalUnitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organisational_unit = organisational_units(:one)
  end

  test "should get index" do
    get organisational_units_url
    assert_response :success
  end

  test "should get new" do
    get new_organisational_unit_url
    assert_response :success
  end

  test "should create organisational_unit" do
    assert_difference('OrganisationalUnit.count') do
      post organisational_units_url, params: { organisational_unit: { country: @organisational_unit.country, geographic_region: @organisational_unit.geographic_region, name: @organisational_unit.name } }
    end

    assert_redirected_to organisational_unit_url(OrganisationalUnit.last)
  end

  test "should show organisational_unit" do
    get organisational_unit_url(@organisational_unit)
    assert_response :success
  end

  test "should get edit" do
    get edit_organisational_unit_url(@organisational_unit)
    assert_response :success
  end

  test "should update organisational_unit" do
    patch organisational_unit_url(@organisational_unit), params: { organisational_unit: { country: @organisational_unit.country, geographic_region: @organisational_unit.geographic_region, name: @organisational_unit.name } }
    assert_redirected_to organisational_unit_url(@organisational_unit)
  end

  test "should destroy organisational_unit" do
    assert_difference('OrganisationalUnit.count', -1) do
      delete organisational_unit_url(@organisational_unit)
    end

    assert_redirected_to organisational_units_url
  end
end
