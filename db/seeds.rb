# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

popular_stocks = ['AAPL', 'MSFT']

#init iex
client = IEX::Api::Client.new

#create new stocks
popular_stocks.each do |stock_symbol|
  quote = client.quote(stock_symbol)
  Stock.create(sym: stock_symbol)
end
