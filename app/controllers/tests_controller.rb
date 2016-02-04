class TestsController < ApplicationController
  before_action :set_category

  def index
    if !session[:account].nil?
      @account = Account.find_by(id: session[:account].id)
    end
  end

  def new
  end

  def show
    @test = Test.find(params[:id])
  end

  def edit
  end

  def update
    if @category.tests.find(params[:id]).update(test_params)
      redirect_to category_tests_path(@category), notice: "Test updated successfully."
    else
      render 'edit'
    end
  end

  def create
    if @category.tests.create(test_params)
      redirect_to category_tests_path(@category), notice: "Test created successfully."
    else
      render 'new'
    end
  end

  def destroy
    @category.tests.find(params[:id]).destroy

    redirect_to category_tests_path(@category), notice: "Test deleted."
  end
  
  def get_tests
    @tests = Category.find(params[:category_id]).tests
  end

  def tests_report
    @team = Team.find(params[:teams])
    @test = Test.find(params[:tests])
    @team_players = @team.players.order("first_name")
  end

private

  def test_params
    params.require(:test).permit(:name, :file, :type_unit, :level, :link)
  end

  def set_category
    @category = Category.find_by(id: params[:category_id])
  end
end
