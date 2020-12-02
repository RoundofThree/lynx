class Account < ApplicationRecord
  before_validation :check_balance
  # validations
  validates :user, presence: true
  validates :account_number, presence: true, uniqueness: true
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :expiry_date, presence: true 
  validate :not_expired 

  belongs_to :user
  
  has_many :transactions, class_name: "Transaction", foreign_key: "payer_account_id"
  
  private

  def assign_expiry_date 
    not_rounded_date = Date.today + 4.years
    self.expiry_date = Date.new(not_rounded_date.year, not_rounded_date.month, -1) # The last day of that month
  end 

  def not_expired 
    if (expiry_date > Date.today)
      true
    else
      errors.add(:expiry_date, "Account is expired")
    end 
  end  

  def check_balance
    if self.new_record?
      self.balance = 0.00
    end
  end

end
