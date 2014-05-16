class NotificationMailer < ActionMailer::Base
  default :from => "soccer-app@gmail.com"

  def notification_new_player(player, current_user)
    @player = player
    @current_user = current_user
    @admin = User.where("type_user = ?", Role::ADMIN).first
    mail(:to => "#{@admin.full_name} <#{@admin.email}>", :subject => "Soccer-app new player Notification")
  end

end