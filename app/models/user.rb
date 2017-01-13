class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, allow_nil: true
  has_many :contacts, dependent: :destroy

  def active_contacts
    contacts.where(active: true)
  end
end
