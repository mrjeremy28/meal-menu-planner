class MealPlansController < ApplicationController
  before_action :set_meal_plan, only: %i[ show edit update destroy ]
  before_action :set_breadcrumbs, only: [:show, :new, :edit]

  # GET /meal_plans or /meal_plans.json
  def index
    @meal_plans = MealPlan.all
    add_breadcrumb("Home", "/")
    add_breadcrumb("Meal Plans")
  end

  # GET /meal_plans/1 or /meal_plans/1.json
  def show
    add_breadcrumb(@meal_plan.to_s)
  end

  # GET /meal_plans/new
  def new
    start_date_param = params.dig(:meal_plan, :start_date)
    end_date_param = params.dig(:meal_plan, :end_date)
    @recipe_options = Recipe.all.map do |recipe|
      [recipe.name, recipe.id]
    end
    @meal_plan = MealPlan.new(
      start_date: start_date_param || Date.today,
      end_date: end_date_param || 6.days.from_now.to_date
    )
    # @meal_plan.recipe_ingredients.order(:order).build

    # @meal_plan.meals.build(date: Date.today)

    @meal_plan.build_meals

    add_breadcrumb("New")
  end

  # GET /meal_plans/1/edit
  def edit
    add_breadcrumb(@meal_plan.to_s, meal_plan_path(@meal_plan))
    add_breadcrumb("Edit")
  end

  # POST /meal_plans or /meal_plans.json
  def create
    @meal_plan = MealPlan.new(meal_plan_params)

    respond_to do |format|
      if @meal_plan.save
        format.html { redirect_to meal_plan_url(@meal_plan), notice: "Meal plan was successfully created." }
        format.json { render :show, status: :created, location: @meal_plan }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meal_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meal_plans/1 or /meal_plans/1.json
  def update
    respond_to do |format|
      if @meal_plan.update(meal_plan_params)
        format.html { redirect_to meal_plan_url(@meal_plan), notice: "Meal plan was successfully updated." }
        format.json { render :show, status: :ok, location: @meal_plan }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meal_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meal_plans/1 or /meal_plans/1.json
  def destroy
    @meal_plan.destroy!

    respond_to do |format|
      format.html { redirect_to meal_plans_url, notice: "Meal plan was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal_plan
      @meal_plan = MealPlan.find(params[:id])
    end

    def set_breadcrumbs
      add_breadcrumb("Home", "/")
      add_breadcrumb("Meal Plans", meal_plans_path)
    end

    # Only allow a list of trusted parameters through.
    def meal_plan_params
      params.require(:meal_plan).permit(
        :start_date,
        :end_date,
        meals_attributes: [
          :id,
          :date,
          :recipe_id
        ]
      )
    end
end
