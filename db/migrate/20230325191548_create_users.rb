class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email
      t.string :phone
      t.integer :age
      t.boolean :status
      t.datetime :discarded_at

			t.index %i[discarded_at]

      t.timestamps null: false
    end
  end
end
