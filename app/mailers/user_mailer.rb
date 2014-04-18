class UserMailer < ActionMailer::Base
  default from: "techmasterswork@gmail.com"

  def work_order(order, user)
    @user = user
    @order = order
    mail to: @user.email, subject: "Work Order Form"
  end
end 