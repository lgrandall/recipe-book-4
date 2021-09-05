class RecipeIngredient < ApplicationRecord
  belongs_to :recipe, inverse_of: :recipe_ingredients
  belongs_to :ingredient, inverse_of: :recipe_ingredients
  belongs_to :measurement, inverse_of: :recipe_ingredients, optional: true
  belongs_to :quantity, inverse_of: :recipe_ingredients, optional: true
end