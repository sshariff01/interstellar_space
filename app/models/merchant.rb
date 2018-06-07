class Merchant < ApplicationRecord

  has_many :shops, foreign_key: :merchant_fk

  validates_uniqueness_of :email
  validate :email_must_be_valid_format

  has_secure_password

  VALID_EMAIL_REGEX = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  def email_must_be_valid_format
    errors.add(:email, 'must be valid') if !VALID_EMAIL_REGEX.match(email)
  end
end
