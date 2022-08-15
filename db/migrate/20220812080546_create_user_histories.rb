class CreateUserHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :user_histories do |t|
      t.integer :user_id
      t.string :status
      t.string :symbol
      t.decimal :amount, default: 0

      t.timestamps
    end
  end
end
