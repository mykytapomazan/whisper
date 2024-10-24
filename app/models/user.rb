class User < ApplicationRecord
  # Include default Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_one_attached :profile_picture
  has_many :posts, dependent: :destroy

  # Validations
  validates :full_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :username, presence: true, length: { minimum: 3, maximum: 20 },
                       uniqueness: { case_sensitive: false }

  attr_writer :login

  # Returns the profile picture if attached, otherwise the default image URL
  def profile_picture_url
    if profile_picture.attached?
      profile_picture
    else
      'default_profile_picture.svg'
    end
  end

  # Login method for authentication (using either username or email)
  def login
    @login || username || email
  end

  # Devise custom authentication logic
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)

    if login
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value',
                                    { value: login.strip.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end
end
