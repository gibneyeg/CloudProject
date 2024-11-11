# db/migrate/[TIMESTAMP]_add_index_to_books.rb
class AddIndexToBooks < ActiveRecord::Migration[7.0]
  def change
    add_index :books, :isbn, unique: true
  end
end