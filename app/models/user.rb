class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true

  has_secure_password

  before_save { self.email = format(self.email) }
  before_create :generate_confirmation_token

  private

  def format(email) # downcase domain part of the email
    arr = email.split('@')
    arr.last.downcase!
    arr.join('@')
  end

  def generate_confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s
  end
end
