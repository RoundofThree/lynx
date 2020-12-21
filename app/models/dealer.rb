class Dealer < ApplicationRecord
  validates :name, presence: true
  validates :account_number, presence: true, length: { is: 14 }
  validates :min_amount, presence: true
  validates :max_amount, presence: true
  validates :max_amount, numericality: { greater_than_or_equal_to: :min_amount }
  validates :frequency, numericality: { less_than_or_equal_to: 300 }
  validates :is_vendor, presence: true
end
