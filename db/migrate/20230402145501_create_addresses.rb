class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
			t.references :user, foreign_key: true, null: false

      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.string :zip_code

      t.timestamps
    end
  end
end
