class Style < ApplicationRecord
  validates :bank_name, presence: true, length: {in: 1...20}
  has_one_attached :header_logo
  has_one_attached :home_main_marketing_image
  has_one_attached :home_main_marketing_card_image_1
  has_one_attached :home_main_marketing_card_image_2
  has_one_attached :home_main_marketing_card_image_3
  has_one_attached :login_background_image
  has_one_attached :login_sigup_logo_image

  serialize :home_links_1, Array
  serialize :home_links_2, Array

  # validate only one style stored in DB
  validate :single_row, on: :create

  private

  def single_row
    if self.class.any?
      errors.add(:base, "Only one style row can exist")
    end
  end

end
