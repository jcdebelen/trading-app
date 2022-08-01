json.extract! transaction, :id, :user_id, :type, :status, :amount, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
