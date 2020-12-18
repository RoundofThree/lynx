class Account < ApplicationRecord
  # A user has many accounts.
  belongs_to :user
  # An account has many transactions.
  has_many :transactions, dependent: :destroy

  # validations
  validates :user, presence: true
  validates :account_number, presence: true, uniqueness: true, length: { is: 14 }
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :cvv, presence: true, length: { in: 3...4 }
  validates :expiry_date, presence: true 
  validate :not_expired

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

  def not_expired
    if expiry_date.present? && expiry_date > Date.today
      true
    else
      errors.add(:expiry_date, 'Account is expired')
    end
  end
end
