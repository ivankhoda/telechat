class User < ApplicationRecord
  has_secure_password validations: false

  has_many :messages, dependent: :delete_all

  # before_save :downcase_email if :email

  validates :username, uniqueness: true

  # validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true if :email

  private

  def downcase_email
    self.email = email.downcase
  end
end
