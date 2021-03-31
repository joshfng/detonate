class RemoveUnusedIndexes < ActiveRecord::Migration[6.1]
  def change
    remove_index :heartbeats, name: "index_heartbeats_on_switch_id"
    remove_index :switches, name: "index_switches_on_user_id"
    remove_index :users, name: "index_users_on_unconfirmed_email_bidx"
  end
end
