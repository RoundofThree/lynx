class Account < ApplicationRecord
  # validations
  validates :user, presence: true
  validates :account_number, presence: true, uniqueness: true
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_validation :check_balance
  belongs_to :user

  private

    def check_balance
      if self.new_record?
        self.balance = 0.00
      end
    end

end
