class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.string :type
      t.string :status
      t.integer :amount

      t.timestamps
    end
  end
end
