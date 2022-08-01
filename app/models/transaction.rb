class Transaction < ApplicationRecord

    validates :user_id, presence: true
    validates :type, presence: true
    validates :status, presence: true
    validates :amount, presence: true
    
end
