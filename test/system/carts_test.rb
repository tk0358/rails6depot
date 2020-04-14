require "application_system_test_case"
# 11 assertions
# mailは2タイプで送信されるので、メール本文のassertionは×2される

class CartsTest < ApplicationSystemTestCase
  include AuthenticationHelpers
  include ActiveJob::TestHelper

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
      click_on "Empty Cart"
    end

    assert_no_selector "h2", text: "Your Cart"
  end

  test "send_notification_mail_in_invalid_cart_ access" do
    perform_enqueued_jobs do
      visit 'carts/invalid'
    end

    mail = ActionMailer::Base.deliveries.last

    assert_equal ["tk0358a@yahoo.co.jp"], mail.to
    assert_equal 'Auto message<do-not-reply@example.com>', mail[:from].value
    assert_equal 'Someone has accessed invalid url', mail.subject

    # htmlメール、textメールの2回assert_match行われる
    assert_match /invalid/, mail.body.encoded 
  end
end
