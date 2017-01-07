class AddGravatarToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :gravatar, :text
  end
end
