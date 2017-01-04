require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user) }
  it { should validate_uniqueness_of(:email) }
  it { should have_secure_password }
end
