require 'test_helper'

class TaskMailerTest < ActionMailer::TestCase
  test "notifier" do
    mail = TaskMailer.notifier
    assert_equal "Notifier", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
