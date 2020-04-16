require "application_system_test_case"
# 4 assertions
class ProductsTest < ApplicationSystemTestCase
  include AuthenticationHelpers
  # 未実装
  # include ActionText::SystemTestHelper
  
  setup do
    @product = products(:one)
    @description = "rich text description"
  end

  test "visiting the index" do
    visit products_url
    assert_selector "h1", text: "Products"
  end

  # DescriptionがRich Text のためテストできず
  # test "creating a Product" do
  #   visit products_url
  #   click_on "New Product"

  #   fill_in "Description", with: @description
  #   fill_in "Image url", with: @product.image_url
  #   fill_in "Price", with: @product.price
  #   fill_in "Title", with: "Testing new Product title"
  #   click_on "Create Product"

  #   assert_text "Product was successfully created"
  #   click_on "Back"
  # end

  # DescriptionがRich Text のためテストできず
  # test "updating a Product" do
  #   visit products_url
  #   click_on "Edit", match: :first

  #   fill_in "Description", with: @description
  #   fill_in "Image url", with: @product.image_url
  #   fill_in "Price", with: @product.price
  #   fill_in "Title", with: "Karel The Robot in a Nutshell"
  #   click_on "Update Product"

  #   assert_text "Product was successfully updated"
  #   click_on "Back"
  # end

  test "destroying a Product" do
    visit products_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Product was successfully destroyed"
  end
end
