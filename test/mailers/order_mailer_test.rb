require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase

  test "received" do
    mail = OrderMailer.received(orders(:one))
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["ruru_test@example.com"], mail.to
    assert_equal ["ruru@example.com"], mail.from
    assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderMailer.received(orders(:one))
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["ruru_test@example.com"], mail.to
    assert_equal ["ruru@example.com"], mail.from
    assert_match /Programming Ruby 1.9/, mail.body.encoded
  end

end
