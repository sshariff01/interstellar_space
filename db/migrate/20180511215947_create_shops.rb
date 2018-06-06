class CreateShops < ActiveRecord::Migration[5.1]
  def change
    create_table :shops, id: false do |t|
      t.primary_key :pk
      t.string      :name, limit: 256, null: false
      t.text        :description
      t.string      :subdomain, limit: 25, unique: true, null: false

      t.timestamps
    end
  end
end
