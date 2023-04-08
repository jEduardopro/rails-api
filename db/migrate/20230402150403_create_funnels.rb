class CreateFunnels < ActiveRecord::Migration[7.0]
  def change
    create_table :funnels do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :url
      t.string :module
      t.json :metadata

      t.timestamps
    end
  end
end
