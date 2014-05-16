class PlayersController < ApplicationController

  def new
    @user = User.new
  end
  
  def create
    unless player_exist?
      @user = User.new(player_params)
      @user.team_ids = params[:teams]
      @user.type_user = Role::PLAYER

      if @user.save
        NotificationMailer.notification_new_player(@user, current_user).deliver
        redirect_to coach_path, notice: "User created successfully."
      else
        render 'new'
      end
    else
      redirect_to new_player_path 
    end
  end

  def player_params
    params.permit(:teams, :birthday, :first_name, :last_name, :email, :password, :password_confirmation)
  end

  def player_exist?
    User.where("email = ? and type_user = ?", params[:email], Role::PLAYER).first.present?
  end
end
