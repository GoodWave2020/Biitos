class ChangeColumnNotNullBody < ActiveRecord::Migration[5.2]
  def change
    def change
      change_column_null :comments, :body, null: false
    end
  end
end
