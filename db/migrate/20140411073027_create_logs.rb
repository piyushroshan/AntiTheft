class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :ip_address
      t.references :device, index: true

      t.timestamps
    end
  end
end
