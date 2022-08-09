class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :action
      t.integer :stock_id
      t.integer :stock_price
      t.integer :stock_quantity

      t.timestamps
    end
  end
end
