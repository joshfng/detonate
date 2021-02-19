class CreateHeartbeats < ActiveRecord::Migration[6.1]
  def change
    create_table :heartbeats, id: :uuid do |t|
      t.uuid :switch_id, null: false, foreign_key: true
      t.boolean :confirmed, default: false

      t.timestamps
    end

    add_index :heartbeats, :switch_id
  end
end
