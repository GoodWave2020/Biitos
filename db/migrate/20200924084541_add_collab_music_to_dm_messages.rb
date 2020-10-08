class AddCollabMusicToDmMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :dm_messages, :collab_music, :text
  end
end
