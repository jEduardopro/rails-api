class AddEmailConfirmationToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email_confirmation, :datetime
  end
end
