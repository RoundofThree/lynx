class Style < ApplicationRecord
  default_value_for :bank_name, 'Lynx'
  
  # validate only one style stored in DB
  validate :single_row, on: :create 

  # current appearance options set 
  def current 
    first
  end 

  private

  def single_row
    if self.class.any?
      errors.add(:base, "Only one style row can exist")
    end
  end

end
