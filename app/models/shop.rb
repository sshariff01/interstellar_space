class Shop < ApplicationRecord
  belongs_to :merchant, foreign_key: :merchant_fk

  validates :name, length: { minimum: 3, maximum: 40 }
  validate :name_must_not_contain_only_whitespace

  validates :subdomain, length: { minimum: 3, maximum: 25 }, :uniqueness => true
  validate :subdomain_must_contain_only_valid_characters

  INVALID_WHITESPACE_REGEX = /(^\s|\s$)/
  VALID_SUBDOMAIN_REGEX = /(^[A-Za-z0-9\-]*$)/

  def name_must_not_contain_only_whitespace
    errors.add(:name, 'must not begin or end with whitespace') if INVALID_WHITESPACE_REGEX.match(name)
  end

  def subdomain_must_contain_only_valid_characters
    errors.add(:subdomain, 'may only contain alphanumeric characters') if !VALID_SUBDOMAIN_REGEX.match(subdomain)
  end

  def urn(domain)
    "#{subdomain}.#{domain}"
  end
end
