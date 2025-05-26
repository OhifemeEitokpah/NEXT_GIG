class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.references :venue, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.date :date
      t.time :time
      t.integer :max_slots

      t.timestamps
    end
  end
end
