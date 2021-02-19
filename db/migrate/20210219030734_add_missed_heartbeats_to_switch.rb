class AddMissedHeartbeatsToSwitch < ActiveRecord::Migration[6.1]
  def change
    add_column :switches, :missed_heartbeats, :integer, default: 0, null: false
  end
end
