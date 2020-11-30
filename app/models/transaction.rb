class Transaction < ApplicationRecord
  belongs_to :payer_account, class_name: "Account", foreign_key: "payer_account_id"

  validates :payer_account, presence: true
  validates :amount, presence: true, numericality: { :greater_than => 0, less_than_or_equal_to: :account_balance }
  validates :currency, presence: true, if: :currency_is_account_currency
  validates :payee_account_number, presence: true, length: { is: 14 } # 14 digits
  validates :payee_fullname, presence: true

  CURRENCY_TYPES = ["£", "$", "€"]
  validates_inclusion_of :currency, in: CURRENCY_TYPES

  private

  def currency_is_account_currency
    if payer_account
      self.currency == payer_account.currency
    else
      false
    end
  end

  def account_balance
    if payer_account
      payer_account.balance
    else
      0.00
    end
  end

end
