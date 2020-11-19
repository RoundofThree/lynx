class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  # validations
  validates :firstname, presence: true, length: {maximum: 127}
  validates :lastname, presence: true, length: {maximum: 127}
  validates :email, confirmation: true
  validates :phone, presence: true  # should check for validity?
  validates :birth_date, presence: true
  validate :validate_age
  # database relations
  has_many :accounts
  # before actions
  before_save :format_name

  GENDER_TYPES = [ ["Male", false], [ "Female", true] ]
  validates_inclusion_of :is_female, in: [true, false]

  private

  def format_name
    self.firstname = self.firstname.upcase
    self.lastname = self.lastname.upcase
  end

  def validate_age
    if birth_date.present? && birth_date > 18.years.ago.to_i
      errors.add(:birth_date, 'You should be over 18')
    end
  end
end
