class Transaction < ApplicationRecord
  belongs_to :account

  validates :account, presence: true
  # validates :amount, presence: true, numericality: { :greater_than => 0, less_than_or_equal_to: :account_balance } # change
  validates :amount, presence: true, numericality: { other_than: 0 }
  validates :currency, presence: true, if: :currency_is_account_currency
  validates :dealer_account_number, presence: true, length: { is: 14 } # 14 digits
  validates :dealer_name, presence: true

  CURRENCY_TYPES = ["GBP", "USD", "EUR"]
  validates_inclusion_of :currency, in: CURRENCY_TYPES

  before_save :format_name

  def self.search(keyword)
    if !keyword.blank?
      keyword = "%#{keyword.upcase}%" 
      transactions = self.where("dealer_name LIKE ?", keyword)
      transactions 
    else 
      self.all
    end 
  end

  private

  def format_name
    self.dealer_name = self.dealer_name.upcase
  end

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
