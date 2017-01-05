class ChangeBirthdatToBirthdate < ActiveRecord::Migration[5.0]
  def change
    rename_column :contacts, :birthdat, :birthdate
  end
end
