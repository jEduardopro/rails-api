class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
			t.references :funnel, foreign_key: true

      t.string :title
      t.string :module
      t.json :metadata

      t.timestamps
    end
  end
end
