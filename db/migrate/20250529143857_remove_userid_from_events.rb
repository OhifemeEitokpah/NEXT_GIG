class RemoveUseridFromEvents < ActiveRecord::Migration[7.1]
  def change
    remove_reference :events, :user, foreign_key: true, null: false
  end
end
