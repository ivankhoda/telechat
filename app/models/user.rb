class User < ApplicationRecord
  has_secure_password validations: false
  validates_presence_of :password, on: :create
  has_many :messages, dependent: :destroy

  before_save :downcase_email

  validates :username, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  private

  def downcase_email
    self.email = email.downcase
  end
end
