class User < ApplicationRecord
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :email, uniqueness: true
  validates :password, presence: true, length: {minimum: 8}
  has_secure_password
  # validates :password, confirmation: true
  validates :name, presence: true, length: {minimum: 5}, allow_blank: true
  before_create :init_username

  def set_reset_token
    self.reset_token = SecureRandom.hex(10)
    self.reset_sent_at = Time.now
    self.save(:validate => false)
  end

  private

  def init_username
    self.name = self.email.split("@")[0]
  end
end
