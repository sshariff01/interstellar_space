class Merchant < ApplicationRecord
  has_secure_password

  # TODO: Write test for validation
  validates_uniqueness_of :email
end
