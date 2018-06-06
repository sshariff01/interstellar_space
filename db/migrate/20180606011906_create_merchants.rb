class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
      t.string :email, limit: 256, unique: true, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
