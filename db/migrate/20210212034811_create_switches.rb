# frozen_string_literal: true

class CreateSwitches < ActiveRecord::Migration[6.1]
  def change
    create_table :switches, id: :uuid do |t|
      t.uuid :user_id, null: false, foreign_key: true
      t.text :name_ciphertext, null: false
      t.text :content_ciphertext
      t.boolean :detonated, default: false, null: false
      t.integer :heartbeat_interval, default: 0, null: false
      t.integer :max_missed_heartbeats, default: 5, null: false

      t.timestamps
    end

    add_index :switches, :user_id
  end
end