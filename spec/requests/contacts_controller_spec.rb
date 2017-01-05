require 'rails_helper'

describe 'contact resource' do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  let(:contact) { FactoryGirl.build(:contact) }
  before(:each) do
    user.save
    contact.user = user
    contact.save
  end

  def auth_headers(user)
    token = Knock::AuthToken.new(payload: { sub: user.id }).token
    {
      'ACCEPT' => 'application/json',
      'Authorization' => "Bearer #{token}"
    }
  end

  describe 'authenticated requests' do
    it 'index' do
      get '/contacts', headers: auth_headers(user)
      expect(response.status).to eq(200)
    end
    it 'creates with valid input' do
      post '/contacts', params: { contact: { email: 'aadfs@sfadsdfa.com' } },
                        headers: auth_headers(user)
      expect(response.status).to eq(200)
    end

    it 'fails with invalid input' do
      post '/contacts', params: { contact: {} },
                        headers: auth_headers(user)
      expect(response.status).to eq(400)
    end

    it 'show' do
      get "/contacts/#{contact.id}", headers: auth_headers(user)
      expect(response.status).to eq(200)
    end

    it 'delete' do
      get "/contacts/#{contact.id}", headers: auth_headers(user)
      expect(response.status).to eq(200)
    end

    # ensure privacy
    # request action to resource not belonging to current_user
    describe "requests to other user's resource" do
      it "should not show other user's contacts" do
        get "/contacts/#{contact.id}", headers: auth_headers(other_user)
        expect(response.status).to eq(400)
      end

      it 'delete' do
        get "/contacts/#{contact.id}", headers: auth_headers(other_user)
        expect(response.status).to eq(400)
      end
    end
  end
end
