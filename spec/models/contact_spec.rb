require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:user) { FactoryGirl.build(:user) }
  let(:contact) {FactoryGirl.build(:contact)}
  before(:example) do
    contact.user = user
  end

  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:user) }
  it { should belong_to(:user) }

end
