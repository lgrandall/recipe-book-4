class CreateRecipeInstructions < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_instructions do |t|
      t.references :recipe
      t.references :instruction
      t.integer :order
    end
  end
end
