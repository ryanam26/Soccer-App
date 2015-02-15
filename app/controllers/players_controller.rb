class PlayersController < ApplicationController
  before_action :check_user_type, only: [:edit, :index, :destroy, :new, :create, :update, :import]

  def show
    @player = Player.find(params[:id])
    @categories = Category.all
    @rank_age = @player.user_for_age.count
    @overall_rank = Player.count
  end

  def history
    @player = Player.find(params[:id])
  end
  
  def index
    if current_user.standard?
      redirect_to root
    elsif !session[:account].nil?
      @account = session[:account]
      @players = Player.joins(:teams).where("account_id = ?", @account.id).order(:last_name)
    elsif current_user.admin?
      @players = Player.all.order(:last_name)
    else
      redirect_to account_select_path
    end
  end

  def new
    if current_user.standard?
      @player = current_user.players.new
    else
      @users = User.joins(:accounts).where("account_id = ?", session[:account].id)
      @player = Player.new
    end
    @account = session[:account]
    @teams = @account.teams
  end
  
  def create
    @user = User.find(params[:user_id])
    @player = @user.players.new(player_params)
    @player.team_ids = params[:teams]
    @player.birthday = Date.new params[:birthday]['(1i)'].to_i, params[:birthday]['(2i)'].to_i, params[:birthday]['(3i)'].to_i

    if @player.save
      #NotificationMailer.notification_new_player(@user, current_user).deliver
      #NotificationMailer.notification_to_player(@user).deliver
      redirect_to coach_path(session[:account]), notice: "Player created successfully."
    else
      render 'new'
    end
  end

  def edit
    if session[:account].nil?
      redirect_to account_select_path, notice: "Please select which account you're acting under first."
    else
      @account = session[:account]
      @player = Player.find(params[:id])
    end
  end
  
  def update
    @player = Player.find(params[:id])
    if @player.update(player_params)
      redirect_to player_path(@player), :notice => "Player updated successfully"
    else
      render 'edit'
    end
  end

  def coach_report
    @team = Team.find(params[:teams])
    @test = Test.find(params[:tests])
    @position = @test.type_unit == Unit::TIME ? @team.team_system_rank_time(@test.id) : @team.team_system_rank_numeric(@test.id).to_i.ordinalize
    @average = @test.type_unit == Unit::TIME ? @team.team_average_time(@test.id) : @team.team_average_numeric(@test.id)
  end

  def compare_players
    @player = Player.find(params[:player])
    @player_compare = Player.find(params[:player_compare])
    @test = Test.find(params[:test])
  end

  def import

    csv_text = params[:csv_players].read
    csv = CSV.parse(csv_text, :headers => true, :force_quotes => true)
    csv.each do |row|
      user = User.find_by(:email => row['email'])
      if user.nil?
        user = User.new
        user.first_name = row['first name']
        user.last_name = row['last name']
        user.email = row['email']
        user.password = '12345678'
        user.password_confirmation = '12345678'
        user.type_user = Role::STANDARD
        user.team_ids = params[:teams]
        user.save!
      end

      player = user.players.new
      player.first_name = row['first name']
      player.last_name = row['last name']
            
      if user.players.count > 0
        user.players.each do |existing_player|
          if existing_player.full_name == player.full_name
            player = existing_player
            break
          end
        end
      end
      
      #CSV will overwrite birthdays but not names because I'm currently using names as the searchable field
      player.birthday = row['birthday'].to_date
      
      #Assign teams.  Will not overwrite old teams.
      params[:teams].each do |team_id|
        player.teams << Team.find(team_id)
      end

      player.save!

    # csv.each do |row|
      # @user = User.where(:email => row['email']).first
      # if @user
        # puts "Ya tenemos al #{@user.inspect}"
        # params["teams"].each do |team_id|
          # t = Team.find(team_id)
          # @user.teams << t
          # puts "grabo #{@user.save}"
          # puts @user.teams.inspect
        # end
      # else
        # @user = User.new
        # @user.team_ids = params[:teams]
        # @user.first_name = row['first name']
        # @user.last_name = row['last name']
        # @user.birthday = Date.civil(row['birthday'].to_i, 1,1)
        # @user.email = row['email']
        # @user.password = "12345678"
        # @user.password_confirmation = "12345678"
        # @user.type_user = Role::PLAYER
        # @user.save
      # end
    # end
    
    end

    redirect_to coach_path(session[:account]), notice: "Users created successfully."
  end

  def destroy
    player = Player.find(params[:id]).destroy
    flash[:notice] = "Player " + player.full_name + " deleted."
    redirect_to players_path 
  end
  
  private
  
  def player_params
    params.permit(:teams, :birthday, :first_name, :last_name)
  end
  
  def check_user_type
    if current_user.standard?
      redirect_to root_path, notice: "You do not have the permissions to do that action."
    end
  end
  
end
