class CreateShops < ActiveRecord::Migration[5.1]
  def change
    create_table :shops do |t|
      t.string      :name, limit: 256
      t.text        :description
      t.string      :subdomain, limit: 25

      t.timestamps
    end
  end
end
