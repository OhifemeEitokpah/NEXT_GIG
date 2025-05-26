class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :role, :integer
    add_column :users, :bio, :string
    add_column :users, :genre, :string
  end
end
