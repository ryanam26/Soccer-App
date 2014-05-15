class UsersController < ApplicationController
before_action :set_user, only: [:show, :update, :edit]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def show
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
    if @user.save
      redirect_to users_url, notice: "User created successfully."
    else
      render 'new'
    end
	end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy

    redirect_to users_url, notice: "User deleted."
  end

	def user_params
    params.require(:user).permit(:birthday, :first_name, :last_name, :type_user, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end
  
end