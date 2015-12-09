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

  context '#destroy' do
    let(:image) { create :image, resource: File.open("#{Rails.root}/spec/fixtures/images/carne1.jpg") }
    let(:path)  { create :path, image: image }

    let(:merchant) { create(:merchant) }

    it 'can not be deleted if associated to an offer' do
      offer = create(:offer, merchant: merchant)

      expect {
        merchant.destroy
      }.to_not change(Merchant, :count)
    end

    it 'can not be deleted if associated to a stage' do
      stage = create(:stage, merchant: merchant, image: image, path: path)

      expect {
        merchant.destroy
      }.to_not change(Merchant, :count)
    end
  end

end
