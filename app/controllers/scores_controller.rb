class ScoresController < ApplicationController
  def index
    @test = Test.find(params[:tests])
    @team = Team.find(params[:teams])
  end

  def create
    @test = Test.find(params[:test_id])
    params[:player].each do |p|
      unless p[1] == ""
        @test.time? ? value = Time.parse(p[1]).to_f : value =  p[1].to_f
        Score.create(:player_id => p[0].to_i, :test_id => params[:test_id].to_i, :value => value)
      end
    end
    redirect_to coach_path(session[:account]), notice: "Scores successfully saved"
  end

  def edit
    @score = Score.find(params[:id])
    @test = Test.find(@score.test_id)
  end

  def update
    score = Score.find(params[:id])
    @test = Test.find(score.test_id)
    @player = player.find(score.player_id)
    @scores = @player.scores.where(:test_id => score.test_id)

    @test.time? ? value = Time.parse(params[:score][:value]).to_f : value =  params[:score][:value].to_f
    score.update_attribute(:value, value)
    render("manage")
  end

  def destroy
    score = Score.find(params[:id])
    @player = Player.find(score.player_id)
    @scores = @player.scores.where(:test_id => score.test_id)
    @test = Test.find(score.test_id)
    score.destroy

    render("manage")
  end

  def manage
    @player = Player.find(params[:player])
    @scores = @user.scores.where(:test_id => params[:tests])
    @test = Test.find(params[:tests])
  end

end
