class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :edit]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def show
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_url, notice: "category updated successfully."
    else
      render 'edit'
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_url, notice: "category created successfully."
    else
      render 'new'
    end
  end

  def destroy
    @category = Category.find_by(id: params[:id])
    @category.destroy

    redirect_to categories_url, notice: "category deleted."
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find_by(id: params[:id])
  end
end
