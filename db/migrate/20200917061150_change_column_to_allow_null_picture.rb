class ChangeColumnToAllowNullPicture < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :picture, :text, null: true
  end
end
