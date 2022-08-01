class Transaction < ApplicationRecord
    validates :user_id, presence: true
    validates :action, presence: true
    validates :status, presence: true
    validates :amount, presence: true

    has_one :stock, dependent: :destroy
    belongs_to :user
    
end
