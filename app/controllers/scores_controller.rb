class ScoresController < ApplicationController
  def index
    @test = Test.find(params[:test_id])
    @teams = current_user.accounts.last.teams
  end

  def create
    @test = Test.find(params[:test_id])
    params[:player].each do |p|
      @test.type_unit == Unit::TIME ? value = Time.parse(p[1]).to_f : value =  p[1].to_f
      
      unless score_exist?(p[0])
        Score.create(:user_id => p[0].to_i, :test_id => params[:test_id].to_i, :value => value)
      else
        @score.update_attribute(:value, value)
      end

    end  
    redirect_to coach_path, notice: "Scores successfully saved"
  end

  def score_exist?(user_id)
    @score = Score.where(:user_id => user_id, :test_id => params[:test_id], :created_at => Time.now.beginning_of_day..Time.now.end_of_day).first
    @score.present?
  end

end
