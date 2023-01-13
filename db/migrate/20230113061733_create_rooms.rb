class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :to_user_id
      t.text :last_message

      t.timestamps
    end
  end
end
