# inside app/mailers/hello_mailer.rb
class HelloMailer < ApplicationMailer

    default from: 'me@example.com'
  
    def welcome_email
      @user = params[:user]
      mail(to: @user[:email], subject: 'Welcome to My Awesome Site')
    end
  
  end
  