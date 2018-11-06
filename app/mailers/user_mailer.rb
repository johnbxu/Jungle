class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def receipt_email(recipient)
    mail(to: recipient, subject: 'Your Jungle purchase confirmation')
  end
end
