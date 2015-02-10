class NotificationMailer < ActionMailer::Base
  default :from => "soccer-app@gmail.com"

  def notification_new_player(player, current_user)
    @player = player
    @current_user = current_user
    @admin = User.where("type_user = ?", Role::ADMIN).first
    mail(:to => "#{@admin.full_name} <#{@admin.email}>", :subject => "Soccer-app new player Notification")
  end

  def notification_to_player(player)
     @player = player
     mail(:to => "#{@player.full_name} <#{@player.user.email}>", :subject => "Soccer-app new player Notification")
  end

  def notification_to_user(user, password)
    @user = user
    @password = password
    mail(:to => "#{@user.full_name} <#{@user.email}>", :subject => "Soccer-app new user Notification")
  end

end