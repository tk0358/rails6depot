require 'test_helper'

class SupportRequestMailerTest < ActionMailer::TestCase
  def setup
    @support_request = support_requests(:one)
  end
  test "respond" do
    mail = SupportRequestMailer.respond(@support_request)
    assert_equal "Re: #{@support_request.subject}", mail.subject
    assert_equal [@support_request.email], mail.to
    assert_equal ["support@example.com"], mail.from
    assert_match @support_request.body, mail.body.encoded
  end

end
