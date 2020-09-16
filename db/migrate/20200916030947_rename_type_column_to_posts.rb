class RenameTypeColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :type, :music_type
  end
end
