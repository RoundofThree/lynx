class Transaction < ApplicationRecord
  belongs_to :payer_account, class_name: "Account", foreign_key: "payer_account_id"
  validates :payer_account_number, presence: true, length: { is: 8 }
  validates :amount, presence: true, numericality: true
  validates :currency, presence: true

end
