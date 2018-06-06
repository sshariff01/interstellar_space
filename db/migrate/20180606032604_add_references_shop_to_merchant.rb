class AddReferencesShopToMerchant < ActiveRecord::Migration[5.1]
  def change
    add_column :shops, :merchant_fk, :integer, index: true
    add_foreign_key :shops, :merchants, column: :merchant_fk
  end
end
