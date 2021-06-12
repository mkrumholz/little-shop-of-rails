class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.string :name
      t.decimal :percentage, precision: 5, scale: 4
      t.integer :quantity_threshold
      t.timestamps
    end
  end
end
