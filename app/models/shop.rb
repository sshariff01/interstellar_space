class Shop < ApplicationRecord

  belongs_to :merchant, foreign_key: :merchant_fk

  has_many :products, foreign_key: :shop_fk

  validates :name, length: { minimum: 3, maximum: 200 }
  validate :name_must_not_contain_only_whitespace

  validates :subdomain, length: { minimum: 3, maximum: 50 }, :uniqueness => true
  validate :subdomain_must_contain_only_valid_characters

  WHITESPACE_REGEX = /(^\s|\s$)/
  VALID_SUBDOMAIN_REGEX = /(^[A-Za-z0-9\-]*$)/

  def name_must_not_contain_only_whitespace
    errors.add(:name, 'must not begin or end with whitespace') if WHITESPACE_REGEX.match(name)
  end

  def subdomain_must_contain_only_valid_characters
    errors.add(:subdomain, 'may only contain alphanumeric characters') if !VALID_SUBDOMAIN_REGEX.match(subdomain)
  end

  def urn(domain)
    "#{subdomain}.#{domain}"
  end

end
