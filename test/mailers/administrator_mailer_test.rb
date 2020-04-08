require 'test_helper'

class AdministratorMailerTest < ActionMailer::TestCase
  test "failure_occured" do
    mail = AdministratorMailer.failure_occured
    assert_equal "Failure occured", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
