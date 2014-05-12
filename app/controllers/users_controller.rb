class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def show
		@user = User.find_by(id: params[:id])
	end

	def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    if params[:user][:password].blank?
		  params[:user].delete(:password)
		  params[:user].delete(:password_confirmation)
		end

    @user = User.find_by(id: params[:id])

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
    params.require(:user).permit(:first_name, :last_name, :type,:email, :password, :password_confirmation)
  end
end
