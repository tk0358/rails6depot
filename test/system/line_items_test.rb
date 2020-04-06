require "application_system_test_case"
# 1asserton
class LineItemsTest < ApplicationSystemTestCase

  test "new line item should be highlighted" do
    visit store_index_url

    click_on "Add to Cart", match: :first

    assert_selector ".line-item-highlight"
  end
end
