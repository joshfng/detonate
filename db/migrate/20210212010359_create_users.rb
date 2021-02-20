# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto'

    create_table :users, id: :uuid do |t|
      t.boolean :users, :admin, default: false, null: false
      t.timestamps
    end
  end
end
