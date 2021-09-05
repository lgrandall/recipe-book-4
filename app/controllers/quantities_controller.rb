class QuantitiesController < ApplicationController
  before_action :set_quantity, only: %i[ show edit update destroy ]

  # GET /quantities or /quantities.json
  def index
    @quantities = Quantity.all
  end

  # GET /quantities/1 or /quantities/1.json
  def show
  end

  # GET /quantities/new
  def new
    @quantity = Quantity.new
  end

  # GET /quantities/1/edit
  def edit
  end

  # POST /quantities or /quantities.json
  def create
    @quantity = Quantity.new(quantity_params)

    respond_to do |format|
      if @quantity.save
        format.html { redirect_to @quantity, notice: "Quantity was successfully created." }
        format.json { render :show, status: :created, location: @quantity }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quantity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quantities/1 or /quantities/1.json
  def update
    respond_to do |format|
      if @quantity.update(quantity_params)
        format.html { redirect_to @quantity, notice: "Quantity was successfully updated." }
        format.json { render :show, status: :ok, location: @quantity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quantity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quantities/1 or /quantities/1.json
  def destroy
    @quantity.destroy
    respond_to do |format|
      format.html { redirect_to quantities_url, notice: "Quantity was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quantity
      @quantity = Quantity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quantity_params
      params.require(:quantity).permit(:amount)
    end
end
