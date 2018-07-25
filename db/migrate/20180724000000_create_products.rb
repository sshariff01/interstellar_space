class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products, id: false do |t|
      t.primary_key :pk
      t.string      :name, limit: 256, null: false
      t.text        :description
      t.decimal     :price, precision: 10, scale: 4

      t.timestamps
    end

    add_column :products, :shop_fk, :integer, index: true

    add_foreign_key :products, :shops, primary_key: :pk, column: :shop_fk
  end
end
