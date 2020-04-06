require "application_system_test_case"
# 6 assertions

class CartsTest < ApplicationSystemTestCase
  setup do
    @cart = carts(:one)
  end

  test "visiting the index" do
    visit carts_url
    assert_selector "h1", text: "Carts"
  end

  test "creating a Cart" do
    visit store_index_url
    click_on "Add to Cart", match: :first

    assert_selector "#cart"
  end

  test "verify add a cart button" do
    visit store_index_url

    assert_no_selector "h2", text: "Your Cart"
    click_on "Add to Cart", match: :first

    assert_selector "h2", text: "Your Cart"
  end

  test "verify empty cart button" do
    visit store_index_url
    click_on "Add to Cart", match: :first

    assert_selector "h2", text: "Your Cart"

    page.accept_confirm 'Are you sure?' do
      click_on "Empty cart"
    end

    assert_no_selector "h2", text: "Your Cart"
  end
end
