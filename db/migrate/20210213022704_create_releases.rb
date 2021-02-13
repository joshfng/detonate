class CreateReleases < ActiveRecord::Migration[6.1]
  def change
    create_table :releases, id: :uuid do |t|
      t.uuid :switch_id, null: false, foreign_key: true
      t.integer :release_type, default: 0, null: false
      t.text :release_address_ciphertext
      t.boolean :release_sent, default: false, null: false

      t.timestamps
    end

    add_index :releases, :switch_id
  end
end
