class CreateHeartbeatDestinations < ActiveRecord::Migration[6.1]
  def change
    create_table :heartbeat_destinations, id: :uuid do |t|
      t.uuid :switch_id, null: false, foreign_key: true
      t.integer :heartbeat_destination_type, default: 0, null: false
      t.text :heartbeat_destination_address_ciphertext

      t.timestamps
    end

    add_index :heartbeat_destinations, :switch_id
  end
end
