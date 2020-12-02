class Account < ApplicationRecord
  # A user has many accounts.
  belongs_to :user
  # An account has many transactions.
  has_many :transactions, class_name: "Transaction", foreign_key: "payer_account_id"

  # validations
  validates :user, presence: true
  validates :account_number, presence: true, uniqueness: true
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :cvv, presence: true, length: {in: 3...4}

  # before_validation :check_balance

  
  private

    def check_balance
      if self.new_record?
        self.balance = 0.00
      end
    end

end
