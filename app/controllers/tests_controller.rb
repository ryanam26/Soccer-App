class TestsController < ApplicationController
  before_action :set_category

  def index
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
      redirect_to category_tests_path(@category), notice: "test updated successfully."
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

private

  def test_params
    params.require(:test).permit(:name, :file, :type_unit, :level, :link)
  end

  def set_category
    @category = Category.find_by(id: params[:category_id])
  end
end
