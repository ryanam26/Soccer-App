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

  def team_report
    @test = Test.find(params[:tests])
    ps = Hash.new
    if verify_teams_and_year(params[:team][:id], params[:year])
      params[:team][:id].each do |team_id|
        if !team_id.empty?
          team = Team.find_by(id: team_id)
          team.players.each do |player|
            pass = true
            if !params[:year].empty?
              if player.birthday.year != params[:year].to_i
                pass = false
              end
            end
            if pass
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
          end
        end
      end
    else
      redirect_to :back
    end
    @players_scores = Hash[ps.sort_by{|k,v| v}.reverse]
  end

  private

  def verify_teams_and_year(teams, year)
    pass = true
    if teams.length == 1
      flash[:teams] = "You must select at least one team"
      pass = false
    end
    if !year.empty? && !is_number?(year)
      flash[:year] = "Date of birth only numbers are accepted"
      pass = false
    end
    return pass
  end

  def is_number? string
    true if Float(string) rescue false
  end

end
