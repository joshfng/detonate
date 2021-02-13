# frozen_string_literal: true

class CreateSwitches < ActiveRecord::Migration[6.1]
  def change
    create_table :switches do |t|
      t.references :user, null: false, foreign_key: true
      t.text :name_ciphertext, null: false
      t.text :content_ciphertext
      t.integer :checkin_interval, default: 0, null: false
      t.integer :max_missed_checks, default: 5, null: false
      t.integer :missed_checks, default: 0, null: false
      t.integer :checkin_window, default: 86_400, null: false

      t.timestamps
    end
  end
end
