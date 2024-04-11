class QuantityUnitsController < ApplicationController
  before_action :set_quantity_unit, only: %i[ show edit update destroy ]
  before_action :set_breadcrumbs, only: [ :show, :new, :edit ]

  # GET /quantity_units or /quantity_units.json
  def index
    @quantity_units = QuantityUnit.all
    add_breadcrumb("Home", "/")
    add_breadcrumb("Quantity Units")
  end

  # GET /quantity_units/1 or /quantity_units/1.json
  def show
    add_breadcrumb(@quantity_unit.name)
  end

  # GET /quantity_units/new
  def new
    @quantity_unit = QuantityUnit.new
    add_breadcrumb("New")
  end

  # GET /quantity_units/1/edit
  def edit
    add_breadcrumb(@quantity_unit.name, quantity_unit_path(@quantity_unit))
    add_breadcrumb("Edit")
  end

  # POST /quantity_units or /quantity_units.json
  def create
    @quantity_unit = QuantityUnit.new(quantity_unit_params)

    respond_to do |format|
      if @quantity_unit.save
        format.html { redirect_to quantity_unit_url(@quantity_unit), notice: "Quantity unit was successfully created." }
        format.json { render :show, status: :created, location: @quantity_unit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quantity_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quantity_units/1 or /quantity_units/1.json
  def update
    respond_to do |format|
      if @quantity_unit.update(quantity_unit_params)
        format.html { redirect_to quantity_unit_url(@quantity_unit), notice: "Quantity unit was successfully updated." }
        format.json { render :show, status: :ok, location: @quantity_unit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quantity_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quantity_units/1 or /quantity_units/1.json
  def destroy
    @quantity_unit.destroy!

    respond_to do |format|
      format.html { redirect_to quantity_units_url, notice: "Quantity unit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quantity_unit
      @quantity_unit = QuantityUnit.find(params[:id])
    end

    # Set breadcrumbs
    def set_breadcrumbs
      add_breadcrumb("Home", "/")
      add_breadcrumb("Quantity Units", quantity_units_path)
    end

    # Only allow a list of trusted parameters through.
    def quantity_unit_params
      params.require(:quantity_unit).permit(:name)
    end
end
