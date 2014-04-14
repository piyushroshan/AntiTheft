class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :macaddress
      t.string :nickname
      t.text :description
      t.integer :user_id
      t.boolean :stolen
      t.string :secret_key

      t.timestamps
    end
    add_index :devices, :macaddress
  end
end
