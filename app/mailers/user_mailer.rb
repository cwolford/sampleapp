class UserMailer < ActionMailer::Base
  default from: "techmasterswork@gmail.com"

  def work_order(user)
    @user = user
    mail to: @user.email, subject: "Work Order Form"
  end
end 