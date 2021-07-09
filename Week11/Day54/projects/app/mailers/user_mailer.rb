class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url = 'http://localhost:3000/users/sign_in'
    mail(to: @user, subject: "Welcome to our Projects App!")
  end
end
