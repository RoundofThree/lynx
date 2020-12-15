class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
 
  # the password cannot be nil dut to default devise modules.
  GENDER_TYPES = [['Male', false], ['Female', true]].freeze
  validates_inclusion_of :is_female, in: [true, false]
  validates :firstname, presence: true, length: { maximum: 127 }
  validates :lastname, presence: true, length: { maximum: 127 }
  validates :email, confirmation: true, uniqueness: true
  validates :phone, presence: true
  validates :birth_date, presence: true
  validate :validate_age # should be over 18 years old
  validate :admin_passphrase_if_admin # admin should have a non-blank passphrase 
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

  def authenticate_admin_passphrase(passphrase = '') 
    self.admin_passphrase_digest == create_hash(passphrase)
  end

  private

  # use SHA256 hash to store second admin password
  def create_hash(phrase = '')
    if !phrase.blank?
      Digest::SHA2.hexdigest(phrase)
    end
  end

  def format_name
    self.firstname = firstname.upcase
    self.lastname = lastname.upcase
  end

  def validate_age
    errors.add(:birth_date, 'You should be over 18') if birth_date.present? && birth_date > DateTime.now.years_ago(18)
  end

  # to test 
  def admin_passphrase_if_admin 
    errors.add(:admin_passphrase_hash, 'Invalid') if admin && admin_passphrase_digest.blank?
  end 

end
