class Account < ApplicationRecord
  # validations
  validates :user, presence: true
  validates :account_number, presence: true, uniqueness: true
  validates :balance, presence: true, numericality: true

  before_validation :check_balance

  belongs_to :user

  private
    def check_balance
      if self.new_record?
        self.balance = 0.00
      end
    end

end
