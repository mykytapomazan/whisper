class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :username, presence: true, length: { minimum: 3, maximum: 20 }, uniqueness: { case_sensitive: false }

  attr_writer :login

  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_condition)
    conditions = warden_condition.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value',
                                    { value: login.strip.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end
end
