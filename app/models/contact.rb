class Contact < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  validates_associated :user
  validates :email, presence: true, uniqueness: true
end
