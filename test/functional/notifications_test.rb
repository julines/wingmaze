require 'test_helper'

class NotificationsTest < ActionMailer::TestCase
  test "enquiry" do
    mail = Notifications.enquiry
    assert_equal "Enquiry", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
