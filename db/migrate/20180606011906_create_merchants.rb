class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants, id: false do |t|
      t.primary_key :pk
      t.string :email, limit: 256, unique: true, null: false
      t.string :name, limit: 256, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
