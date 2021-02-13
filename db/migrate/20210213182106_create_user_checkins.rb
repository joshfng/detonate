class CreateUserCheckins < ActiveRecord::Migration[6.1]
  def change
    create_table :user_checkins, id: :uuid do |t|
      t.uuid :checkin_id, null: false, foreign_key: true
      t.boolean :checkin_confirmed, default: false

      t.timestamps
    end
  end
end
