class Transaction < ApplicationRecord
  belongs_to :payer_account, class_name: "Account", foreign_key: "payer_account_id"

  validates :account, presence: true
  # validates :amount, presence: true, numericality: { :greater_than => 0, less_than_or_equal_to: :account_balance } # change
  validates :amount, presence: true, numericality: { other_than: 0 }
  validates :currency, presence: true, if: :currency_is_account_currency
  validates :dealer_account_number, presence: true, length: { is: 14 } # 14 digits
  validates :dealer_name, presence: true

  CURRENCY_TYPES = ["GBP", "USD", "EUR"]
  validates_inclusion_of :currency, in: CURRENCY_TYPES

  private

  def currency_is_account_currency
    if account
      self.currency == account.currency
    else
      false
    end
  end

  def account_balance
    if account
      account.balance
    else
      0.00
    end
  end

end
