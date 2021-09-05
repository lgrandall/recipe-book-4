class Instruction < ApplicationRecord
  has_many :recipe_instructions
  has_many :recipe, through: :recipe_instructions
  accepts_nested_attributes_for :recipe_instructions

  attr_accessor :order
end
