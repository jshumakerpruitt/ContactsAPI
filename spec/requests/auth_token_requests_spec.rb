require 'rails_helper'

describe 'user_token resource' do
  let(:user) { FactoryGirl.create(:user) }

  describe 'create' do
    it 'returns 201 with valid params' do
      user.update_attribute(:password, 'weakpass1')
      post '/user_token',
           params: { auth:
                       { email: user.email,
                         password:  user.password } }
      expect(response.status).to eq(201)
    end

    it 'returns 404 with invalid params' do
      # attempt to authenticate with invalid password
      post '/user_token',
           params: { auth:
                       { email: user.email,
                         password:  'wrongpassword' } }
      expect(response.status).to eq(404)
    end
  end
end
