class FriendMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.friend_mailer.friend_created.subject
  #
  def friend_created
    @greeting = "Hi"

    mail(
      from: "support@if1.com",
      to: "kevin.hoffman.france@gmail.com", 
      subject: "new friend created"
      # mail to: User.first.email
    )
  end
end
