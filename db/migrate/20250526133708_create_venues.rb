class CreateVenues < ActiveRecord::Migration[7.1]
  def change
    create_table :venues do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :address
      t.string :city
      t.string :country
      t.text :description

      t.timestamps
    end
  end
end
