class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  # active column allows soft deletion
  # but api users shouldn't have to think about it
  before_create do
    self.active = true
  end

  has_many :contacts

  def self.from_token_request(request)
    email = request.params['auth'] && request.params['auth']['email']
    user = find_by email: email
    user.active ? user : nil
  end
end
