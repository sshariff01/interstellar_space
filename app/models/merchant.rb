class Merchant < ApplicationRecord

  has_many :shops, foreign_key: :merchant_fk

  validates :name, length: { minimum: 3, maximum: 200 }
  validate :name_must_not_contain_only_whitespace

  validates_uniqueness_of :email
  validate :email_must_be_valid_format

  has_secure_password

  WHITESPACE_REGEX = /(^\s|\s$)/
  VALID_EMAIL_REGEX = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  def name_must_not_contain_only_whitespace
    errors.add(:name, 'must not begin or end with whitespace') if WHITESPACE_REGEX.match(name)
  end

  def email_must_be_valid_format
    errors.add(:email, 'must be valid') if !VALID_EMAIL_REGEX.match(email)
  end
end
