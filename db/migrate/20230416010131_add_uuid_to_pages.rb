class AddUuidToPages < ActiveRecord::Migration[7.0]
  def change
		add_column :pages, :uuid, :string, null: false, index: {unique: true}
		#Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
