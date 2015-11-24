require 'rails_helper'

describe Merchant, type: :model do

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:telephone) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:hashed_password) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
    it { should validate_uniqueness_of(:token).allow_nil }
  end
end
