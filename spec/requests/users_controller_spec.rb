require 'rails_helper'

describe 'user resource' do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  let(:unpersisted_user) { FactoryGirl.build(:user) }

  def auth_headers(user)
    token = Knock::AuthToken.new(payload: { sub: user.id }).token
    {
      'ACCEPT' => 'application/json',
      'Authorization' => "Bearer #{token}"
    }
  end

  describe 'create' do
    it 'returns 201 with valid params' do
      post '/users',
           params: { user:
                       { email: unpersisted_user.email,
                         password:  'weakpass1',
                         username: unpersisted_user.username },
                     headers: {'ACCEPT' => 'application/json'}}
      expect(response.status).to eq(201)
    end

    it 'returns 400 with invalid params' do
      post '/users',
           params: { user: { username: user.username } }
      expect(response.status).to eq(400)
    end
  end


  describe 'show current_user' do
    before(:each) do
      get "/users/#{user.id}",
          headers: auth_headers(user)
    end

    it 'returns status 200' do
      expect(response.status).to eq(200)
    end

    it 'returns json of current_user' do
      user_hash = JSON.parse(user.to_json)
      response_hash = JSON.parse(response.body)
      user_hash.delete("password")
      response_hash.delete("password")
      expect(response_hash).to eq(user_hash)
    end

    it 'should not show other_user' do
      #user requests users#show of other_user
      get "/contacts/#{other_user.id}",
          headers: auth_headers(user)
      expect(response.status).to eq(400)
    end
  end

  describe 'delete current_user' do
    let(:temp_user) { FactoryGirl.create(:user) }
    before(:each) do
      delete "/users/#{temp_user.id}",
             headers: auth_headers(temp_user)
    end

    it 'returns status 200' do
      expect(response.status).to eq(200)
    end

    it 'sets active to false' do
      temp_user.reload
      expect(temp_user.active).to eq(false)
    end
  end
end
