require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:contact) { FactoryGirl.build(:contact) }
  before(:example) do
    contact.user = user
    allow_any_instance_of(Contact).to receive(:set_gravatar)
    contact.save!
  end

  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user) }
  it { should belong_to(:user) }

  it 'should ignore soft-deleted users' do
    contact.update(active: false)
    expect(user.active_contacts.where(id: contact.id).count).to eq(0)
  end
end
