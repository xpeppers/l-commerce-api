require 'rails_helper'

describe User, type: :model do
  it { should have_many(:orders) }
  it { should have_many(:bought_offers).through(:orders) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:provider_user_id) }

  it { should validate_uniqueness_of(:token) }
end
