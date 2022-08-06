class Stock < ApplicationRecord
    validates :transaction_id, presence: true
    validates :name, presence: true
    validates :price, presence: true

    belongs_to :user
end