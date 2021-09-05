class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  has_many :recipe_instructions
  has_many :instructions, through: :recipe_instructions

  accepts_nested_attributes_for :instructions, allow_destroy: true
  accepts_nested_attributes_for :recipe_instructions
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  accepts_nested_attributes_for :recipe_ingredients

  def ingredients
    recipe_ingredients
  end
end
