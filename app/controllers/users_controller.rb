class UsersController < ApplicationController
before_action :set_user, only: [:show, :update, :edit]
# before_action :charge_teams

	def index
    if current_user.coach?
      @users = User.joins(:accounts).where("account_id = ?", session[:account].id)
		else
      @users = User.all
    end
	end

	def new
		@user = User.new
	end

	def show
    @user = User.find(params[:id])
	end

	def edit
  end

  def update
    if params[:user][:password].blank?
		  params[:user].delete(:password)
		  params[:user].delete(:password_confirmation)
		end

    if @user.update(user_params)
      redirect_to users_url, notice: "User updated successfully."
    else
      render 'edit'
    end
  end

	def create
		@user = User.new(user_params)
    
    if params[:user][:type_user].to_i == Role::STANDARD.to_i
      @user.team_ids = params[:teams]
    end

    if @user.save
      #NotificationMailer.notification_to_user(@user, params[:user][:password]).deliver
      redirect_to users_url, notice: "User created successfully."
    else
      render 'new'
    end
	end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.players.destroy_all
    @user.destroy
    
    redirect_to users_url, notice: "User deleted."
  end

	def user_params
    params.require(:user).permit(:birthday, :first_name, :last_name, :type_user, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def coach_profile
    @account = Account.find(params[:id])
    session[:account] = @account
    @categories = Category.all
    @players = Player.joins(:teams).where("teams.account_id = ?", session[:account]).order(:first_name)
  end

  def charge_teams
    if current_user.coach?
      @show = "display:none"
      @teams = Team.all.where(account_id: session[:account])
    else
      @teams = Team.all
    end
  end
  
end
