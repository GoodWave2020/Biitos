class ChangeColumnToAllowNull < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :icon, :text, null: true, default: nil
  end
end
