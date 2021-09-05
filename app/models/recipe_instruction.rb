class RecipeInstruction < ApplicationRecord
  belongs_to :recipe, inverse_of: :recipe_instructions
  belongs_to :instruction, inverse_of: :recipe_instructions
end