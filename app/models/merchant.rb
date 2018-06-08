class Merchant < ApplicationRecord

  has_many :shops, foreign_key: :merchant_fk

  validates :name, length: { minimum: 3, maximum: 200 }
  validate :name_must_not_contain_only_whitespace

  validates_uniqueness_of :email
  validate :email_must_be_valid_format

  has_secure_password
  validate :password_complexity

  WHITESPACE_REGEX = /(^\s|\s$)/
  VALID_EMAIL_REGEX = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  VALID_PASSWORD_REGEX = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/

  def name_must_not_contain_only_whitespace
    errors.add(:name, 'must not begin or end with whitespace') if WHITESPACE_REGEX.match(name)
  end

  def email_must_be_valid_format
    errors.add(:email, 'must be valid') if !VALID_EMAIL_REGEX.match(email)
  end

  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    errors.add :password, 'must be at least eight characters, contain at least one uppercase letter, one lowercase letter, and one number' if !VALID_PASSWORD_REGEX.match(password)
  end
end
