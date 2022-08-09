class User < ApplicationRecord
  after_create :send_admin_mail
  after_create :send_user_mail
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :stocks, dependent: :destroy
  
  enum role: [:trader, :admin]
  after_initialize :set_default_role if :new_record?
  def set_default_role
    self.role ||= :user
  end

  def active_for_authentication? 
    super && approved?
  end 
    
  def inactive_message 
    approved? ? super : :not_approved
  end

  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if recoverable.persisted?
      if recoverable.approved?
        recoverable.send_reset_password_instructions
      else
        recoverable.errors.add(:base, :not_approved)
      end
    end
    recoverable
  end

  #MAILERS
  def send_admin_mail
    AdminMailer.new_user_waiting_for_approval(email).deliver
  end

  def send_user_mail
    UserMailer.user_message_approval(email).deliver
  end
  

end
