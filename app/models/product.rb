class Product < ApplicationRecord

  belongs_to :shop, foreign_key: :shop_fk

  validates :name, presence: true
  validates :price, presence: true

end

