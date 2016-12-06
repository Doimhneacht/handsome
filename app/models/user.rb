class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true

  has_secure_password

  before_save { self.email = User.format(self.email) }
  before_create :generate_confirmation_token

  def activate_email
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  private

  def self.format(email) # downcase domain part of the email
    if !email.empty?
      arr = email.split('@')
      arr.last.downcase!
      return arr.join('@')
    end
    ''
  end

  def generate_confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s
  end
end
