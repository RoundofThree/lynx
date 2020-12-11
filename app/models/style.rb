class Style < ApplicationRecord
  validates :bank_name, presence: true, length: {in: 1...20}
  
  # validate only one style stored in DB
  validate :single_row, on: :create 

  private

  def single_row
    if self.class.any?
      errors.add(:base, "Only one style row can exist")
    end
  end

end
