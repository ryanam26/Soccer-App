class TeamsController < ApplicationController
before_action :set_team, only: [:show, :update, :edit]

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def show
  end

  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to teams_url, notice: "Team updated successfully."
    else
      render 'edit'
    end
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to teams_url, notice: "Team created successfully."
    else
      render 'new'
    end
  end

  def destroy
    @team = Team.find_by(id: params[:id])
    @team.destroy

    redirect_to teams_url, notice: "Team deleted."
  end

  def team_params
    params.require(:team).permit(:name)
  end

  def set_team
    @team = Team.find_by(id: params[:id])
  end
end
