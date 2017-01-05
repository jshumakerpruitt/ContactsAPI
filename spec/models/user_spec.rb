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

  it 'should set active to true before_create' do
    expect(user.active).to eq(true)
  end

  describe '#find_from_token' do
    it 'should lookup the user by email' do
      request = double('Request')
      allow(request).to receive(:params)
        .and_return(
          'auth' => { 'email' => user.email }
        )

      expect(User.from_token_request(request)).to eq(user)
    end

    it 'should ignore soft-deleted users' do
      user.update_attribute(:active, false)
      request = double('Request')
      allow(request).to receive(:params)
        .and_return(
          'auth' => { 'email' => user.email }
        )

      expect(User.from_token_request(request)).to eq(nil)
    end
  end
end
