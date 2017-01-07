class Contact < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  validates_associated :user
  validates :email, presence: true, uniqueness: true

  after_validation do
    digest = Digest::MD5.hexdigest(email)
    self.gravatar = digest
  end
end
