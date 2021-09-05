class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.boolean :expert
      t.text :image_ur

      t.timestamps
    end
  end
end
