class Merchant < ApplicationRecord
  has_secure_password

  has_many :shops, foreign_key: :merchant_fk

  validates_uniqueness_of :email
end
