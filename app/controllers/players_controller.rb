class PlayersController < ApplicationController
  before_action :check_user_type, only: [:edit, :index, :destroy, :new, :create, :update, :import]

  def show
    @player = Player.find(params[:id])
    @categories = Category.all
  end

  def history
    @player = Player.find(params[:id])
    @scores = @player.scores.where(:test_id => params[:test_id]).order('created_at')
  end
  
  def index
    if current_user.standard?
      redirect_to root
    elsif !session[:account].nil?
      @account = session[:account]
      @players = (Player.joins(:teams).where("account_id = ?", @account.id).order(:last_name)).uniq
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
      @player = Player.new
    end
    if current_user.coach?
      @account = session[:account]
      @teams = @account.teams
      @users = @account.users
    else
      @account = Account.all
      @teams = Team.all
      @users = User.all
    end
  end
  
  def create
    @user = User.find_by(:email => params[:user_email]) 
    if @user.nil?
      @user = User.new
      @user.email = params[:user_email]
      @user.password = "12345678"
      @user.password_confirmation = "12345678"
      @user.first_name = params[:first_name]
      @user.last_name = params[:last_name]
      @user.accounts << session[:account] unless session[:account].nil?
      @user.type_user = Role::STANDARD
      @user.save!
    end
    @player = @user.players.new(player_params_create)
    @player.team_ids = params[:teams]
    @player.birthday = Date.new params[:birthday]['(1i)'].to_i, params[:birthday]['(2i)'].to_i, params[:birthday]['(3i)'].to_i

    if @player.save
      #NotificationMailer.notification_new_player(@user, current_user).deliver
      #NotificationMailer.notification_to_player(@user).deliver
      if session[:account].nil?
        redirect_to players_path, notice: "Players created successfully."
      else
        redirect_to coach_path(session[:account]), notice: "Player created successfully."  
      end
      
    else
      render 'new'
    end
  end

  def edit
    if current_user.coach?
      if session[:account].nil?
        redirect_to account_select_path, notice: "Please select which account you're acting under first."
      else
        @teams = session[:account].teams
        @player = Player.find(params[:id])
        @users = User.standard
      end
    elsif current_user.admin?
      @teams = Team.all
      @player = Player.find(params[:id])
      @users = User.standard
    else
      redirect_to root_path, notice: "You do not have the required permissions to edit this player.  Please contact your coach or an administrator."
    end
      
  end
  
  def update
    @player = Player.find(params[:id])
    @player.user = User.find(params[:player][:user_id])
    @player.team_ids = nil
    params[:teams].each do |team_id|
      team = Team.find(team_id)
      @player.teams << team
    end
    @player.birthday = Date.new params[:birthday]['(1i)'].to_i, params[:birthday]['(2i)'].to_i, params[:birthday]['(3i)'].to_i
    if @player.update(player_params_update)
      redirect_to player_path(@player), :notice => "Player updated successfully"
    else
      render 'edit'
    end
  end

  def coach_report
    @test = Test.find(params[:tests])
    ps = Hash.new
    @position_average = Hash.new
    if !params[:teams].nil?
      params[:teams].each do |team_id|
        team = Team.find_by(id: team_id)
        team.players.each do |player|
          if player.has_scores?(@test.id)
            if @test.time?
              score = player.high_time_score(@test.id, params[:date])
              unless score.nil?
                ps[player.full_name] = [score, team.name, player.birthday.year]
              end
            else
              score = player.high_numeric_score(@test.id, params[:date])
              unless score.nil?
                ps[player.full_name] = [score, team.name, player.birthday.year]
              end
            end
          end
        end
        @position_average[team.name] = [@test.type_unit == Unit::TIME ? team.team_system_rank_time(@test.id) : team.team_system_rank_numeric(@test.id).to_i.ordinalize, @test.type_unit == Unit::TIME ? team.team_average_time(@test.id) : team.team_average_numeric(@test.id)]
      end
    end
    @players_scores = Hash[ps.sort_by{|k,v| v}.reverse]
  end

  def compare_players
    if params[:player_1].nil? || params[:player_2].nil? || params[:test].nil?
      redirect_to :back
    else
      @player = Player.find(params[:player_1])
      @player_compare = Player.find(params[:player_2])
      @test = Test.find(params[:test])
    end
  end

  def import

    csv_text = params[:csv_players].read
    csv = CSV.parse(csv_text, :headers => true, :force_quotes => true)
    csv.each do |row|
      user = User.find_by(:email => row['email'].downcase)
      if user.nil?
        puts row['email'].downcase!
        user = User.new
        user.first_name = row['first name'].capitalize
        user.last_name = row['last name'].capitalize
        user.email = row['email']
        user.password = '12345678'
        user.password_confirmation = '12345678'
        user.type_user = Role::STANDARD
        user.save!
      end
      
      
      player = user.players.new
      player.first_name = row['first name'].capitalize
      player.last_name = row['last name'].capitalize
           
      if user.players.count > 0
        user.players.each do |existing_player|
          if existing_player.full_name.downcase == player.full_name.downcase
            player = existing_player
            break
          end
        end
      end
      
      #CSV will overwrite birthdays but not names because I'm currently using names as the searchable field
      player.birthday = row['birthday'].to_date
      
      #Assign teams.  Will not overwrite old teams and will not duplicate teams.
      params[:teams].each do |team_id|
        team = Team.find(team_id)
        unless player.teams.include? team
          player.teams << team
        end
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

    redirect_to coach_path(session[:account]), notice: "Players created successfully."
  end

  def destroy
    player = Player.find(params[:id]).destroy
    flash[:notice] = "Player " + player.full_name + " deleted."
    redirect_to players_path 
  end
  
  def search
    @player = Player.find(params[:player])
    @categories = Category.all
    @rank_age = @player.user_for_age.count
    @overall_rank = Player.count
    render 'players_scores'
  end
  
  def players_scores
    @player = Player.find(params[:id])
    @categories = Category.all
    @rank_age = @player.user_for_age.count
    @overall_rank = Player.count
  end
  
  private
  
  def player_params_create
    params.permit(:teams, :first_name, :last_name, :birthday, :user_id)
  end

  def player_params_update
    params.require(:player).permit(:first_name, :last_name, :user_id)
  end
  
  def check_user_type
    if current_user.standard?
      redirect_to root_path, notice: "You do not have the permissions to do that action."
    end
  end
  
end
