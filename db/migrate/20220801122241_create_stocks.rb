class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :name
      t.integer :price
      t.integer :transaction_id

      t.timestamps
    end
  end
end
