class Transaction < ApplicationRecord
  belongs_to :payer_account, class_name: "Account", foreign_key: "payer_account_id"

  validates :payer_account, presence: true 
  validates :amount, presence: true, numericality: { :greater_than_or_equal_to => 0.01, less_than_or_equal_to: ->(m) { m.payer_account.balance } }
  validates :currency, presence: true, if: :currency_is_account_currency
  validates :payee_account_number, presence: true, length: { is: 8 } # 8 digits
  validates :payee_fullname, presence: true

  private

  def currency_is_account_currency
    if currency != payer_account.currency
      errors.add(:currency, "Currency should be the same as the account's currency")
    end
  end

end
