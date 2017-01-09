class AddOrganizationToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :organization, :string
  end
end
