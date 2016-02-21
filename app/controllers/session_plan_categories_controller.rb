class SessionPlanCategoriesController < ApplicationController
  before_action :validate_visibility
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
    if @session_plan_category.save
      redirect_to session_plan_categories_url, notice: "Category created successfully."
    else
      render 'new'
    end
  end

  def destroy
    @session_plan_category = SessionPlanCategory.find_by(id: params[:id])
    @session_plan_category.destroy

    redirect_to session_plan_categories_url, notice: "category deleted."
  end

  private

    def validate_visibility
      unless current_user.admin? || current_user.session_plans_visible
        redirect_to root_path, notice: 'You do not have the required permissions to view this page.'
      end
    end
    
    def session_plan_category_params
      params.require(:session_plan_category).permit(:name)
    end
  
    def set_session_plan_category
      @session_plan_category = SessionPlanCategory.find_by(id: params[:id])
    end
  
end
