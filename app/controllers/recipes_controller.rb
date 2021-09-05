class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1 or /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
    render "recipes/edit", locals: {recipe: @recipe, recipe_ingredients: @recipe.recipe_ingredients, recipe_instructions: @recipe.recipe_instructions}
  end

  # POST /recipes or /recipes.json
  def create
    puts "LOUIS RANDALL THE PARAMS FIRST IN CREATE ARE: #{recipe_params.inspect}"
    puts "LOUIS RANDALL THE INSTRUCTIONS: #{params["Instruction"]}"

    instruction_params = {}
    ingredient_params = {}
    updated_params = recipe_params
    puts "louis randall the updated_params first look: #{updated_params.inspect}"
    puts "louis randall the updated_params first look new instructions: #{updated_params["New Instructions"]}"

    if params["Ingredient"].present?
      params["Ingredient"].each_with_index do |id, index|
        ingredient_params[id] = [id, params["Quantity"][index].to_d, params["Measurement"][index]]
      end
    end

    if params["Instruction"].present?
      order_instructions = params["Order"].map(&:to_i)
      params["Instruction"].each_with_index do |id, index|
        puts "louis randall the order params: #{params['Order']}"
        instruction_params["#{id} - #{index}"] = [id, order_instructions[index]]
      end
    end

    puts "LOUIS RANDALL THE INSTRUCTION PARAMS: #{params["instructions_attributes"]}"
    puts "LOUIS RANDALL THE UPDATED INSTRUCTION PARAMS: #{instruction_params}"
    instructions_attributes = updated_params["New Instructions"]
    puts "LOUIS RANDALL NEW INSTRUCTIONS FOR YOU: #{instructions_attributes}"

    updated_params.delete("Instruction")
    updated_params.delete("Ingredient")
    updated_params.delete("Quantity")
    updated_params.delete("Measurement")
    puts "LOUIS RANDALL AND NOW THE PARAMS ARE: #{updated_params}"

    puts "LOUIS RANDALL THE DELETE:: #{updated_params.delete("New Instructions")}"


    puts "LOUIS RANDALL AND NOW THE PARAMS ARE: #{updated_params}"
    puts "LOUIS RANDALL THE INGREDIENT PARAMS: #{ingredient_params}"
    @recipe = Recipe.new(updated_params)

    puts "LOUIS RANDALL THE RECIPE: #{@recipe.inspect}"
    respond_to do |format|
      if @recipe.save! && recipe_ingredient_creation(@recipe, ingredient_params) && recipe_instruction_creation(@recipe,instruction_params ) && create_new_instructions(@recipe, instructions_attributes)
        format.html { redirect_to @recipe, notice: "Recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    updated_params = recipe_params
    puts "LOUIS RANDALL THE PARAMS: #{params.inspect}"

    updated_params.delete("Instruction")
    updated_params.delete("Ingredient")
    updated_params.delete("Quantity")
    updated_params.delete("Measurement")
    updated_params.delete("instructions_attributes")

    respond_to do |format|
      if @recipe.update(updated_params)
        format.html { redirect_to @recipe, notice: "Recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy
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

    # Only allow a list of trusted parameters through.
    def recipe_params
      puts "LOUIS RANDALL LOOK AT THE PARAMS: #{params.inspect}"
      params["recipe"]["Ingredient"] = params["Ingredient"]
      puts "LOUIS RANDALL LOOK AT THE PARAMS: #{params.inspect}"
      puts "LOUIS RANDALL THE INSTRUCTION PARAMS: #{params["instructions_attributes"]}"
      puts "LOUIS RANDALL THE INSTRUCTION PARAMS: #{params[:instructions_attributes]}"

      params.require(:recipe).permit(:name, :description, :expert, :image_ur, :Ingredient, :Quantity, :Measurement, :instructions_attributes, ingredient_attributes: [:id, :name, :_destroy], ingredients_attributes: [:id, :name, :_destroy]).merge({"Ingredient": params["Ingredient"]}).merge({"Quantity": params["Quantity"]}).merge({"Instruction": params["Instruction"]}).merge({"New Instructions": params['recipe']['instructions_attributes']})
    end

  def recipe_ingredient_creation(recipe, ingredient_params)
    ingredient_params.each do |key, value|
      puts "LOUIS RANDALL VALUE: #{value.inspect}"
      recipe.recipe_ingredients.find_or_create_by(ingredient_id: value[0], quantity_id:value[1], measurement_id: value[2])
    end
  end

  def recipe_instruction_creation(recipe, instruction_params)
    puts "LOUIS RANDALL instruction_params: #{instruction_params}"
    instruction_params.each do |key, value|
      puts "LOUIS RANDALL THE VALUE "
      recipe.recipe_instructions.find_or_create_by(instruction_id: value[0], order: value[1])
    end
  end

  def create_new_instructions(recipe, instructions_attributes)
    recipe = recipe
    puts "LOUIS RANDALL TEH create_new_instructions: #{instructions_attributes}"
    instructions_attributes.each do |k, v|
      attr = v
      attr["time_amount"] = v["time_amount"].to_i
      puts "LOUIS RANDALL TEH V: #{v.inspect}"
      puts "LOUIS RANDALL TEH V: #{v.inspect}"

      instruction = Instruction.new(short_hand_name: attr["short_hand_name"], description: attr["description"], time_amount: attr["time_amount"])
      recipe.recipe_instructions.find_or_create_by(instruction: instruction, order: attr["order"])
    end
  end
end
