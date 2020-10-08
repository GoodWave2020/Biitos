class ChangeColumnNotNullDmMessage < ActiveRecord::Migration[5.2]
  def change
    change_column_null :dm_messages, :body, null: false
    change_column_null :dm_messages, :conversation_id, null: false
    change_column_null :dm_messages, :user_id, null: false
  end
end
