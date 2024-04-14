class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]
  before_action :set_breadcrumbs, only: [ :show, :new, :edit ]

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.all
    add_breadcrumb("Home", "/")
    add_breadcrumb("Recipes")
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    add_breadcrumb(@recipe.name)
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    @recipe.recipe_ingredients.order(:order).build

    @ingredients = Ingredient.all
    @quantity_units = QuantityUnit.all
    add_breadcrumb("New")
  end

  # GET /recipes/1/edit
  def edit
    @ingredients = Ingredient.all
    @quantity_units = QuantityUnit.all
    add_breadcrumb(@recipe.name, recipe_path(@recipe))
    add_breadcrumb("Edit")
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: "Recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        @ingredients = Ingredient.all
        @quantity_units = QuantityUnit.all
        render(:new, status: 422)
        # format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipe_url(@recipe), notice: "Recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy!

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: "Recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
    # Set breadcrumbs
    def set_breadcrumbs
      add_breadcrumb("Home", "/")
      add_breadcrumb("Recipes", recipes_path)
    end
    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(:name, :servings, :category_id, :instructions, :image,
      recipe_ingredients_attributes: [:id, :quantity, :order, :ingredient_id, :quantity_unit_id])

    end
end
