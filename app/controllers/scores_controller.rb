class ScoresController < ApplicationController
  def index
    @test = Test.find(params[:tests])
    @team = Team.find(params[:teams])
  end

  def create
    @test = Test.find(params[:test_id])
    params[:player].each do |p|
      unless p[1] == ""
        @test.type_unit == Unit::TIME ? value = Time.parse(p[1]).to_f : value =  p[1].to_f
        Score.create(:user_id => p[0].to_i, :test_id => params[:test_id].to_i, :value => value)
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
    @user = User.find(score.user_id)
    @scores = @user.scores.where(:test_id => score.test_id)

    @test.type_unit == Unit::TIME ? value = Time.parse(params[:score][:value]).to_f : value =  params[:score][:value].to_f
    score.update_attribute(:value, value)
    render("manage")
  end

  def destroy
    score = Score.find(params[:id])
    @user = User.find(score.user_id)
    @scores = @user.scores.where(:test_id => score.test_id)
    @test = Test.find(score.test_id)
    score.destroy

    render("manage")
  end

  def manage
    @user = User.find(params[:player])
    @scores = @user.scores.where(:test_id => params[:tests])
    @test = Test.find(params[:tests])
  end

end
