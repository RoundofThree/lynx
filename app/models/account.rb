class Account < ApplicationRecord
  # A user has many accounts.
  belongs_to :user
  # An account has many transactions.
  has_many :transactions, dependent: :destroy

  # validations
  validates :user, presence: true
  validates :account_number, presence: true, uniqueness: true
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :cvv, presence: true, length: { in: 3...4 }

  CURRENCY_TYPES = %w[GBP USD EUR].freeze
  validates_inclusion_of :currency, in: CURRENCY_TYPES

  def self.search(keyword)
    if !keyword.blank?
      where('account_number LIKE ?', "%#{keyword}%")

    else
      all
    end
  end

  private

  def assign_expiry_date
    not_rounded_date = Date.today + 4.years
    self.expiry_date = Date.new(not_rounded_date.year, not_rounded_date.month, -1) # The last day of that month
  end

  def not_expired
    if expiry_date > Date.today
      true
    else
      errors.add(:expiry_date, 'Account is expired')
    end
  end

  def check_balance
    self.balance = 0.00 if new_record?
  end
end
