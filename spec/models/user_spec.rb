require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:email) }

  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:username) }

  it { should validate_presence_of(:password) }
  it { should have_secure_password }

  it { should have_many(:contacts) }
end
