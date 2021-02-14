class CreateSwitchDestinations < ActiveRecord::Migration[6.1]
  def change
    create_table :switch_destinations, id: :uuid do |t|
      t.uuid :switch_id, null: false, foreign_key: true
      t.integer :switch_destination_type, default: 0, null: false
      t.text :switch_destination_address_ciphertext
      t.boolean :switch_destination_notified, default: false, null: false

      t.timestamps
    end

    add_index :switch_destinations, :switch_id
  end
end
