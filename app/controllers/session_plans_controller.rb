class SessionPlansController < ApplicationController
  before_action :validate_visibility
  before_action :set_session_plan_category
  before_action :set_session_plan, only: [:edit, :update, :destroy, :show]
  # GET /session_plans
  # GET /session_plans.json
  def index
    @session_plans = @session_plan_category.session_plans
  end

  # GET /session_plans/1
  # GET /session_plans/1.json
  def show
  end

  # GET /session_plans/new
  def new
  end

  # GET /session_plans/1/edit
  def edit
  end

  # POST /session_plans
  # POST /session_plans.json
  def create
    @session_plan = @session_plan_category.session_plans.new(session_plan_params)

    respond_to do |format|
      if @session_plan.save
        format.html { redirect_to session_plan_category_session_plans_path(@session_plan_category), notice: 'Session plan was successfully created.' }
        format.json { render action: 'show', status: :created, location: @session_plan }
      else
        format.html { render action: 'new' }
        format.json { render json: @session_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /session_plans/1
  # PATCH/PUT /session_plans/1.json
  def update
    if @session_plan_category.session_plans.find(params[:id]).update(session_plan_params)
      redirect_to session_plan_category_session_plans_path(@session_plan_category), notice: "Session Plan updated successfully."
    else
      render 'edit'
    end
  end

  # DELETE /session_plans/1
  # DELETE /session_plans/1.json
  def destroy
    @session_plan_category.session_plans.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to session_plan_category_session_plans_path(@session_plan_category), notice: 'Session Plan was successfully removed.'}
      format.json { head :no_content }
    end
  end

  private
  
    def validate_visibility
      unless current_user.session_plans_visible
        redirect_to root_path, notice: 'You do not have the required permissions to view this page.'
      end
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_session_plan_category
      @session_plan_category = SessionPlanCategory.find(params[:session_plan_category_id])
    end
    
    def set_session_plan
      @session_plan = SessionPlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_plan_params
      params.require(:session_plan).permit(:name, :file, :link)
    end
end
