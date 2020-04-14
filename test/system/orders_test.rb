require "application_system_test_case"
# 33 assertions
class OrdersTest < ApplicationSystemTestCase
  include AuthenticationHelpers
  include ActiveJob::TestHelper

  setup do
    @order = orders(:one)
    @pay = pays(:one) # これがないと payのvalidatesにひっかかりPay must existエラーが発生
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end

  test "check routing number" do
    LineItem.delete_all
    Order.delete_all

    visit store_index_url

    click_on 'Add to Cart', match: :first

    click_on 'Checkout'

    fill_in 'order_name', with: 'Ruru Kaseda'
    fill_in 'order_address', with: '123 Main Street'
    fill_in 'order_email', with: 'ruru@example.com'

    assert_no_selector '#order_routing_number'

    select I18n.t("orders.form.pay_types.check"), from: 'Pay with'

    assert_selector '#order_routing_number'

    fill_in 'Routing #', with: '123456'
    fill_in 'Account #', with: '987654'

    perform_enqueued_jobs do
      click_button 'Place Order'
    end

    orders = Order.all
    assert_equal 1, orders.size

    order = orders.first

    assert_equal 'Ruru Kaseda', order.name
    assert_equal '123 Main Street', order.address
    assert_equal 'ruru@example.com', order.email
    assert_equal 'Check', order.pay.way
    assert_equal 1, order.line_items.size

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["ruru@example.com"], mail.to
    assert_equal 'Ruru <ruru@example.com>', mail[:from].value
    assert_equal 'Pragmatic Store Order Confirmation', mail.subject
  end

  test "credit card number" do
    visit store_index_url

    click_on 'Add to Cart', match: :first

    click_on 'Checkout'

    fill_in 'order_name', with: 'Ruru Kaseda'
    fill_in 'order_address', with: '123 Main Street'
    fill_in 'order_email', with: 'ruru@example.com'

    assert_no_selector '#order_routing_number'

    select I18n.t("orders.form.pay_types.credit_card"), from: 'Pay with'

    assert_selector '#order_credit_card_number'
  end

  test "purchase order number" do
    visit store_index_url

    click_on 'Add to Cart', match: :first

    click_on 'Checkout'

    fill_in 'order_name', with: 'Ruru Kaseda'
    fill_in 'order_address', with: '123 Main Street'
    fill_in 'order_email', with: 'ruru@example.com'

    assert_no_selector '#order_routing_number'

    select I18n.t("orders.form.pay_types.purchase_order"), from: 'Pay with'

    assert_selector '#order_po_number'
  end

  test "ship the order" do
    
    visit orders_url

    perform_enqueued_jobs do
      click_on 'Ship', match: :first
    end

    mail = ActionMailer::Base.deliveries.last
    assert_equal 'Ruru <ruru@example.com>', mail[:from].value
    assert_equal 'Pragmatic Store Order Shipped', mail.subject

    assert_text 'done'
  end

  test "credit card number is short" do
    LineItem.delete_all
    Order.delete_all

    visit store_index_url

    click_on 'Add to Cart', match: :first

    click_on 'Checkout'

    fill_in 'order_name', with: 'Ruru Kaseda'
    fill_in 'order_address', with: '123 Main Street'
    fill_in 'order_email', with: 'ruru@example.com'

    assert_no_selector '#order_credit_card_number'

    select I18n.t("orders.form.pay_types.credit_card"), from: 'Pay with'

    assert_selector '#order_credit_card_number'

    fill_in 'CC #', with: '123456'
    fill_in 'Expiry', with: '11/22'

    perform_enqueued_jobs do
      click_button 'Place Order'
    end

    orders = Order.all
    assert_equal 1, orders.size

    order = orders.first

    assert_equal 'Ruru Kaseda', order.name
    assert_equal '123 Main Street', order.address
    assert_equal 'ruru@example.com', order.email
    assert_equal 'Credit card', order.pay.way
    assert_equal 1, order.line_items.size

    mail = ActionMailer::Base.deliveries.last
    assert_equal [order.email], mail.to
    assert_equal 'Ruru <ruru@example.com>', mail[:from].value
    assert_equal 'Payment processing is failed', mail.subject
    assert_match /The number of digits in your credit card is wrong/, mail.body.encoded
  end

end
