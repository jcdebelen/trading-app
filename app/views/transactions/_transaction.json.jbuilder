json.extract! transaction, :id, :amount, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
