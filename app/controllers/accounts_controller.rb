class AccountsController < ApplicationController
before_action :set_account, only: [:report, :show, :update, :edit]

  def index
    @accounts = Account.active
  end

  def new
    @account = Account.new
  end

  def show
  end

  def edit
  end

  def update
    @account.user_ids = params[:users]

    if @account.update(account_params)
      redirect_to accounts_url, notice: "Account updated successfully."
    else
      render 'edit'
    end
  end

  def create
    @account = Account.new(account_params)
    @account.user_ids = params[:users]
    
    if @account.save
      redirect_to accounts_url, notice: "Account created successfully."
    else
      render 'new'
    end
  end

  def destroy
    @account = Account.find_by(id: params[:id])
    @teams_account = Team.where(account_id: @account.id)
    @teams_account.destroy_all
    @account.destroy

    redirect_to accounts_url, notice: "Account deleted."
  end

  def report
    @account = Account.find_by(id: params[:account_id])
  end

  def canceled_account
    @account = Account.find_by(id: params[:account_id])
    @account.update_attribute(:status, Status::INACTIVE)

    redirect_to accounts_url, notice: "Account canceled."
  end

  def account_params
    params.require(:account).permit(:name, :status)
  end
  
  def set_account
    @account = Account.find_by(id: params[:id])
  end

end
