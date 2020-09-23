class AddDefaultReadToDmMessages < ActiveRecord::Migration[5.2]
  def change
    change_column :dm_messages, :read, :boolean, default: false 
  end
end
