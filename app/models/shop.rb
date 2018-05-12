class Shop < ApplicationRecord
  validates :name, length: { minimum: 3, maximum: 40 }
  validate :name_must_not_contain_only_whitespace

  validates :subdomain, length: { minimum: 3, maximum: 25 }, :uniqueness => true
  validate :subdomain_must_contain_only_valid_characters
  validate :subdomain_must_not_contain_only_whitespace

  INVALID_WHITESPACE_REGEX = /(^\s|\s$)/
  VALID_SUBDOMAIN_REGEX = /(^[A-z0-9\-\s]*$)/

  def name_must_not_contain_only_whitespace
    errors.add(:name, 'Name cannot begin or end with whitespace.') if INVALID_WHITESPACE_REGEX.match(name)
  end

  def subdomain_must_contain_only_valid_characters
    errors.add(:subdomain, 'Subdomain may only contain alphanumeric characters.') if !VALID_SUBDOMAIN_REGEX.match(subdomain)
  end

  def subdomain_must_not_contain_only_whitespace
    errors.add(:subdomain, 'Subdomain cannot begin or end with whitespace.') if INVALID_WHITESPACE_REGEX.match(name)
  end
end
