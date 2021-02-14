class CreateHeartbeats < ActiveRecord::Migration[6.1]
  def change
    create_table :heartbeats, id: :uuid do |t|
      t.uuid :switch_id, null: false, foreign_key: true
      t.uuid :heartbeat_destination_id, null: false, foreign_key: true
      t.boolean :heartbeat_confirmed, default: false

      t.timestamps
    end

    add_index :heartbeats, :switch_id
    add_index :heartbeats, :heartbeat_destination_id
  end
end
