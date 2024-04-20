require "test_helper"

class QuantityUnitsControllerTest < ActionDispatch::IntegrationTest

  setup do
    user = users(:one)
    sign_in user
    # puts "@current_user: #{@current_user.inspect}" # Print signed-in user for debugging
    # sign_in FactoryBot.create(:admin)

    @quantity_unit = quantity_units(:one)
  end

  test "should get index" do

    get quantity_units_url
    assert_response :success

  end

  test "should get new" do
    get new_quantity_unit_url
    assert_response :success
  end

  test "should create quantity_unit" do
    assert_difference("QuantityUnit.count") do
      post quantity_units_url, params: { quantity_unit: { name: quantity_units(:two) } }
    end

    assert_redirected_to quantity_unit_url(QuantityUnit.last)
  end

  test "should show quantity_unit" do
    get quantity_unit_url(@quantity_unit)
    assert_response :success
  end

  test "should get edit" do
    get edit_quantity_unit_url(@quantity_unit)
    assert_response :success
  end

  test "should update quantity_unit" do
    patch quantity_unit_url(@quantity_unit), params: { quantity_unit: { name: @quantity_unit.name } }
    assert_redirected_to quantity_unit_url(@quantity_unit)
  end

  test "should destroy quantity_unit" do
    assert_difference("QuantityUnit.count", -1) do
      delete quantity_unit_url(@quantity_unit)
    end

    assert_redirected_to quantity_units_url
  end
end
