class AddIntervalToSwitches < ActiveRecord::Migration[6.1]
  def change
    add_column :switches, :checkin_interval, :int, default: 0, null: false
    add_column :switches, :max_missed_checks, :int, default: 5, null: false
    add_column :switches, :missed_checks, :int, default: 0, null: false
  end
end
