class Contact < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates_associated :user

  after_validation :set_gravatar

  # active column allows soft deletion
  # but api users shouldn't have to think about it
  before_create do
    self.active = true
  end

  def set_gravatar
    digest = Digest::MD5.hexdigest(email || '')
    self.gravatar = digest
  end
end
