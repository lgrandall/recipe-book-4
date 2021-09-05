class CreateQuantities < ActiveRecord::Migration[5.2]
  def change
    create_table :quantities do |t|
      t.decimal :amount, precision: 4, scale: 2

      t.timestamps
    end
  end
end
