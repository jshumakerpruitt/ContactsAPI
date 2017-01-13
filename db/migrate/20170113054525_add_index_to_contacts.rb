class AddIndexToContacts < ActiveRecord::Migration[5.0]
  def change
    add_index :contacts, [:active, :user_id]
  end
end
