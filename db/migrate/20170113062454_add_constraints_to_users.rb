class AddConstraintsToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :email, :string, null: false
    change_column :users, :username, :string, null: false
  end
end
