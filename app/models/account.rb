class Account < ApplicationRecord
  # validations
  validates :user, presence: true
  validates :account_number, presence: true, uniqueness: true
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_validation :check_balance
  belongs_to :user

  def substract_amount(amount)
    self.balance -= amount
    self.save!  # should raise exception when balance is negative 
  end

  private

    def check_balance
      if self.new_record?
        self.balance = 0.00
      end
    end

end
