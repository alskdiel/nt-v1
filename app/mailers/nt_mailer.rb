class NtMailer < ApplicationMailer

  def forgot_password_email(email)
    @email = email

    o = [('a'..'z'), ('A'..'Z'), (0 .. 9)].map(&:to_a).flatten
    @temp_password = (0...10).map { o[rand(o.length)] }.join

    User.where(email: email).take.update(password: @temp_password)

    # binding pry
    mail(to: email, subject: '[내집탐방] 귀하의 임시 비밀번호가 전송되었습니다.')
  end
end
