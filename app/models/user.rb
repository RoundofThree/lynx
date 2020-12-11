class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  # validations
  # the password can not be nil dut to default devise modules.
  GENDER_TYPES = [ ["Male", false], [ "Female", true] ]
  validates_inclusion_of :is_female, in: [true, false]
  validates :firstname, presence: true, length: {maximum: 127}
  validates :lastname, presence: true, length: {maximum: 127}
  validates :email, confirmation: true, uniqueness: true
  validates :phone, presence: true 
  validates :birth_date, presence: true
  validate :validate_age  # should be over 18 years old
  # database relations
  has_many :accounts, dependent: :destroy
  # before actions
  before_save :format_name

  def self.search(keyword)
    if !keyword.blank?
      keyword = "%#{keyword.upcase}%" 
      users = self.where("firstname LIKE ? OR lastname LIKE ?", keyword, keyword)
      users
    else 
      self.all
    end 
  end

  private

  def format_name
    self.firstname = self.firstname.upcase
    self.lastname = self.lastname.upcase
  end

  def validate_age
    if birth_date.present? && birth_date > DateTime.now.years_ago(18)
      errors.add(:birth_date, 'You should be over 18') 
    end
  end
end
