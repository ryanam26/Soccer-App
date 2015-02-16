class SessionPlanCategoriesController < ApplicationController
  before_action :set_session_plan_category, only: [:show, :update, :edit]

  def index
    @session_plan_categories = SessionPlanCategory.all
  end

  def new
    @session_plan_category = SessionPlanCategory.new
  end

  def show
  end

  def edit
  end

  def update
    if @session_plan_category.update(session_plan_category_params)
      redirect_to session_plan_categories_url, notice: "Category updated successfully."
    else
      render 'edit'
    end
  end

  def create
    @session_plan_category = SessionPlanCategory.new(session_plan_category_params)
    if @category.save
      redirect_to categories_url, notice: "Category created successfully."
    else
      render 'new'
    end
  end

  def destroy
    @session_plan_category = SessionPlanCategory.find_by(id: params[:id])
    @session_plan_category.destroy

    redirect_to session_plan_categories_url, notice: "category deleted."
  end

  def category_params
    params.require(:session_plan_category).permit(:name)
  end

  def set_session_plan_category
    @session_plan_category = SessionPlanCategory.find_by(id: params[:id])
  end
end
