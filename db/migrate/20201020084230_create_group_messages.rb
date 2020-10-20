class CreateGroupMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :group_messages do |t|
      t.text :body, null: false
      t.text :group_music
      t.references :group, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
