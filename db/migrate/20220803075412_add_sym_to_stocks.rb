class AddSymToStocks < ActiveRecord::Migration[7.0]
  def change
    add_column :stocks, :sym, :string
  end
end
