class AddPhotoToUsers < ActiveRecord::Migration[7.0]
  def change
		add_column :users, :cover_photo_data, :text
  end
end
