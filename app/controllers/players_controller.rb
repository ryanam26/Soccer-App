class PlayersController < ApplicationController

  def show
    @user = User.find(params[:player])
    @categories = Category.all
  end

  def history
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(player_params)
    @user.team_ids = params[:teams]
    @user.type_user = Role::PLAYER

    if @user.save
      NotificationMailer.notification_new_player(@user, current_user).deliver
      redirect_to coach_path, notice: "User created successfully."
    else
      render 'new'
    end
  end

  def player_params
    params.permit(:teams, :birthday, :first_name, :last_name, :email, :password, :password_confirmation)
  end

  def coach_report
    @team = Team.find(params[:teams])
    @test = Test.find(params[:tests])
    @position = @test.type_unit == Unit::TIME ? @team.team_system_rank_time(@test.id) : @team.team_system_rank_numeric(@test.id).to_i.ordinalize
    @average = @test.type_unit == Unit::TIME ? @team.team_average_time(@test.id) : @team.team_average_numeric(@test.id)
  end
end
