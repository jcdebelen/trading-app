class CreatePortfolios < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolios do |t|
      t.integer :balance, default: 0
      t.integer :withdraw, default: 0
      t.integer :user_id, null: false
      t.integer :stock_id, null: false

      t.timestamps
    end
    #Ex:- add_index("admin_users", "username")
  end
end
