require "application_system_test_case"

class QuantityUnitsTest < ApplicationSystemTestCase
  setup do
    @quantity_unit = quantity_units(:one)
  end

  test "visiting the index" do
    visit quantity_units_url
    assert_selector "h1", text: "Quantity units"
  end

  test "should create quantity unit" do
    visit quantity_units_url
    click_on "New quantity unit"

    fill_in "Name", with: @quantity_unit.name
    click_on "Create Quantity unit"

    assert_text "Quantity unit was successfully created"
    click_on "Back"
  end

  test "should update Quantity unit" do
    visit quantity_unit_url(@quantity_unit)
    click_on "Edit this quantity unit", match: :first

    fill_in "Name", with: @quantity_unit.name
    click_on "Update Quantity unit"

    assert_text "Quantity unit was successfully updated"
    click_on "Back"
  end

  test "should destroy Quantity unit" do
    visit quantity_unit_url(@quantity_unit)
    click_on "Destroy this quantity unit", match: :first

    assert_text "Quantity unit was successfully destroyed"
  end
end
