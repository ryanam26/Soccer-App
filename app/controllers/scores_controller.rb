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


end
