class AddDefaultIconToUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :icon, :text, :default => 'default.png'
  end
end
