class AddConstraintsToContacts < ActiveRecord::Migration[5.0]
  def change
    change_column :contacts, :email,:string, null: false
    #assure uniqueness with index
    add_index :contacts, :email,unique: true
    change_column :contacts, :user_id, :integer, null: false
    change_column :contacts, :name, :string, null: false
  end
end
