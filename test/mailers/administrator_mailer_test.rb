require 'test_helper'

class AdministratorMailerTest < ActionMailer::TestCase
  test "failure_occured" do
    mail = AdministratorMailer.failure_occured('some_param')
    assert_equal "Someone has accessed invalid url", mail.subject
    assert_equal ["tk0358a@yahoo.co.jp"], mail.to
    assert_equal ["do-not-reply@example.com"], mail.from
    assert_match "Someone has accessed", mail.body.encoded
  end

end
