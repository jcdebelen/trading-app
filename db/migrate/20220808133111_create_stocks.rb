class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :sym, null: false

      t.timestamps
    end
    add_index :stocks, :sym, unique: true
    #Ex:- add_index("admin_users", "username")
  end
end
