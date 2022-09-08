require "test_helper"

class FriendMailerTest < ActionMailer::TestCase
  test "friend_created" do
    mail = FriendMailer.friend_created
    assert_equal "Friend created", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
