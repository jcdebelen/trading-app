class CreatePendings < ActiveRecord::Migration[7.0]
  def change
    create_table :pendings do |t|
      t.string :symbol
      t.integer :quantity
      t.decimal :amount
      t.integer :user_id

      t.timestamps
    end
  end
end
