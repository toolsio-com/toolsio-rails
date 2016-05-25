class Customer < ActiveRecord::Base
  validates :name, presence: true
  validates :phone_number, presence: true, uniqueness: true, allow_nil: true,
    format: { with: /\A[0-9]+$\z/, on: :create, message: 'wrong phone number format' },
    length: { minimum: 10, maximum: 15, message: 'phone number must be b/n 10 to 15 characters' }
  validates :email, presence: true, uniqueness: true, allow_nil: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create ,message: 'wrong email format' }
  validates :address, length: { maximum: 100, 
      too_long: "%{count} characters is the maximum allowed" }

  validate :choose_xand_contact
  
  private
  def choose_xand_contact
    if !(!phone_number.blank? ^ email.blank?) || !(phone_number.blank? ^ !email.blank?)
      errors.add(:base, 'add a phone number or an email. Not both empty')        
    end
  end  
      
end
