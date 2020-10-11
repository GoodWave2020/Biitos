class AddColumnsToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_reference :notifications,  :conversation, foreign_key: true
    add_reference :notifications, :dm_message, foreign_key: true 
  end
end
