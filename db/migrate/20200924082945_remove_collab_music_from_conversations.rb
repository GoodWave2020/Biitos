class RemoveCollabMusicFromConversations < ActiveRecord::Migration[5.2]
  def change
    remove_column :conversations, :collab_music, :text
  end
end
