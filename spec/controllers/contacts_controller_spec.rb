require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  # authenticated controller tests are in requests

  let(:user) { FactoryGirl.create(:user) }
  let(:contact) { FactoryGirl.build(:contact) }
  before(:each) do
    user.save
    contact.user = user
    contact.save
  end

  def auth_headers(user)
    token = Knock::AuthToken.new(payload: { sub: user.id }).token
    headers = {
      'CONTENT_TYPE' => 'application/json',

      'Authorization' => "Bearer #{token}"
    }
    puts headers
    headers
  end

  describe 'unauthenticated requests' do
    it 'index' do
      get :index
      expect(response.status).to eq(401)
    end

    it 'create' do
      post :create
      expect(response.status).to eq(401)
    end

    it 'show' do
      get :show, params: { id: contact }
      expect(response.status).to eq(401)
    end

    it 'delete' do
      delete :destroy, params: { id: contact }
      expect(response.status).to eq(401)
    end
  end
end
