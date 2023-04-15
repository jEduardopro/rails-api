class ChangeTokenFromAuthTokens < ActiveRecord::Migration[7.0]
  def up
		change_column :auth_tokens, :token, :string, null: false
		#Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end

	def down
		change_column :auth_tokens, :token, :string
	end
end
