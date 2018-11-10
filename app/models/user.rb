class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, :password_confirmation, :first_name, :last_name, :email, presence: true
  validates :password, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.downcase.strip)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
