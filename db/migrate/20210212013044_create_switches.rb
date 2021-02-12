class CreateSwitches < ActiveRecord::Migration[6.1]
  def change
    create_table :switches do |t|
      t.references :user, null: false, foreign_key: true
      t.text :name_ciphertext, null: false
      t.text :content_ciphertext

      t.timestamps
    end
  end
end
