class Transaction < ApplicationRecord
  belongs_to :account

  validates :account, presence: true
  validates :amount, presence: true, numericality: { other_than: 0 }
  validates :currency, presence: true, on: :update 
  validates :dealer_account_number, presence: true, length: { is: 14 } # 14 digits
  validates :dealer_name, presence: true

  CURRENCY_TYPES = %w[GBP USD EUR].freeze
  validates_inclusion_of :currency, in: CURRENCY_TYPES, on: :update

  before_save :format_name
  before_save :set_currency

  def self.search(keyword)
    if !keyword.blank?
      keyword = "%#{keyword.upcase}%"
      where('dealer_name LIKE ?', keyword)
    else
      all
    end
  end

  private

  def set_currency
    self.currency = account.currency
  end 

  def format_name
    self.dealer_name = dealer_name.upcase
  end
end
