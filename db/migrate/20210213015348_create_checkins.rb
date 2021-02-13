class CreateCheckins < ActiveRecord::Migration[6.1]
  def change
    create_table :checkins, id: :uuid do |t|
      t.uuid :switch_id, null: false, foreign_key: true
      t.integer :checkin_type, default: 0, null: false
      t.text :checkin_address_ciphertext

      t.timestamps
    end

    add_index :checkins, :switch_id
  end
end
