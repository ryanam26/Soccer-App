class TeamsController < ApplicationController
before_action :set_account

  def index
    
  end

  def new
  end

  def show
  end

  def edit
  end

  def update
    if @account.teams.find(params[:id]).update(team_params)
      redirect_to account_teams_path(@account), notice: "Team updated successfully."
    else
      render 'edit'
    end
  end

  def create
    if @account.teams.create(team_params)
      redirect_to account_teams_path(@account), notice: "Team created successfully."
    else
      render 'new'
    end
  end

  def destroy
    @account.teams.find(params[:id]).destroy

    redirect_to account_teams_path(@account), notice: "Team deleted."
  end

  def team_params
    params.require(:team).permit(:name)
  end

  def set_account
    @account = Account.find_by(id: params[:account_id])
  end
end
