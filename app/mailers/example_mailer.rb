class ExampleMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'TDVpass recupera password')
  end
end
