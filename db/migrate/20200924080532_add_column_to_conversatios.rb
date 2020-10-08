class AddColumnToConversatios < ActiveRecord::Migration[5.2]
  def change
    add_column :conversations, :collab_music, :text
  end
end
