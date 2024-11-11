class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :isbn
      t.string :author
      t.text :description
      t.boolean :available
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
