class RemoveUserIdFromAuthTokens < ActiveRecord::Migration[7.0]
  def change
    remove_column :auth_tokens, :user_id, :bigint
  end
end
