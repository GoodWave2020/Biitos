class ChangeColumnToNotifications < ActiveRecord::Migration[5.2]
  def change
    rename_column :notifications, :visiter_id, :visitor_id
  end
end
