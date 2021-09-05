class Quantity < ApplicationRecord
  has_many :recipe_ingredients
  accepts_nested_attributes_for :recipe_ingredients

end
