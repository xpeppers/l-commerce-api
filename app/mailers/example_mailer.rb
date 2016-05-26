class ExampleMailer < ApplicationMailer
  def welcome_email(user, temporary_code)
    @user = user
    @temporary_code = temporary_code
    mail(to: @user.email, subject: 'TDVpass recupera password')
  end
end
