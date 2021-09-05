class CreateInstructions < ActiveRecord::Migration[5.2]
  def change
    create_table :instructions do |t|
      t.string :short_hand_name
      t.text :description
      t.integer :time_amount

      t.timestamps
    end
  end
end
