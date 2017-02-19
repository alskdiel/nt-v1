class NtMailer < ApplicationMailer

  def forgot_password_email(email)
    @email = email

    o = [('a'..'z'), ('A'..'Z'), (0 .. 9)].map(&:to_a).flatten
    @temp_password = (0...10).map { o[rand(o.length)] }.join

    User.where(email: email).take.update(password: @temp_password)

    # binding pry
    mail(to: email, subject: 'Password Forgot Email')
  end
end
