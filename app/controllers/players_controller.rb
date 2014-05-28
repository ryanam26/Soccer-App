class PlayersController < ApplicationController

  def show
    @user = User.find(params[:player])
    @categories = Category.all
    @rank = @user.user_for_age.count
  end

  def history
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @account = Account.find(params[:id])
  end
  
  def create
    @user = User.new(player_params)
    @user.team_ids = params[:teams]
    @user.type_user = Role::PLAYER
    @user.birthday = Date.civil(*params[:birthday].sort.map(&:last).map(&:to_i))

    if @user.save
      #NotificationMailer.notification_new_player(@user, current_user).deliver
      #NotificationMailer.notification_to_player(@user).deliver
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

  def compare_players
    @user = User.find(params[:user])
    @user_compare = User.find(params[:user_compare])
    @test = Test.find(params[:test])
  end

  def import

    csv_text = params[:csv_players].read
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      @user = User.new
      @user.team_ids = params[:teams]
      @user.first_name = row['first name']
      @user.last_name = row['last name']
      @user.birthday = Date.civil(row['birthday'].to_i, 1,1)
      @user.email = row['email']
      @user.password = "12345678"
      @user.password_confirmation = "12345678"
      @user.type_user = Role::PLAYER
      @user.save
    end

    redirect_to coach_path, notice: "Users created successfully."
  end

end
