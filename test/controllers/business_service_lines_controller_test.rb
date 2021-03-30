require 'test_helper'

class BusinessServiceLinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @business_service_line = business_service_lines(:one)
  end

  test "should get index" do
    get business_service_lines_url
    assert_response :success
  end

  test "should get new" do
    get new_business_service_line_url
    assert_response :success
  end

  test "should create business_service_line" do
    assert_difference('BusinessServiceLine.count') do
      post business_service_lines_url, params: { business_service_line: { name: @business_service_line.name, organisational_unit_id: @business_service_line.organisational_unit_id, tier: @business_service_line.tier } }
    end

    assert_redirected_to business_service_line_url(BusinessServiceLine.last)
  end

  test "should show business_service_line" do
    get business_service_line_url(@business_service_line)
    assert_response :success
  end

  test "should get edit" do
    get edit_business_service_line_url(@business_service_line)
    assert_response :success
  end

  test "should update business_service_line" do
    patch business_service_line_url(@business_service_line), params: { business_service_line: { name: @business_service_line.name, organisational_unit_id: @business_service_line.organisational_unit_id, tier: @business_service_line.tier } }
    assert_redirected_to business_service_line_url(@business_service_line)
  end

  test "should destroy business_service_line" do
    assert_difference('BusinessServiceLine.count', -1) do
      delete business_service_line_url(@business_service_line)
    end

    assert_redirected_to business_service_lines_url
  end
end
