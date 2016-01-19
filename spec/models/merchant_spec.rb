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

  context 'email validation' do
    let (:merchant){ create (:merchant)}

    it 'returns error with an invalid email' do
        merchant.email = 'invalid email'
        merchant.valid?
        expect(merchant.errors[:email].size).to eq(1)
    end
  
    it 'does not return errors with a valid email' do
        merchant.valid?
        expect(merchant.errors[:email].size).to eq(0)
    end
  
  end

  context '#update' do
    let (:merchant){ create (:merchant)}

    it 'does not change hashed_password if new password is empty' do
      old_hashed_password = merchant.hashed_password

      merchant.update(password: '')

      expect(merchant.hashed_password).to eq(old_hashed_password)
    end

    it 'changes hashed_password if new password is not empty' do
      old_hashed_password = merchant.hashed_password

      merchant.update(password: 'A NEW PASSWORD')

      expect(merchant.hashed_password).to_not eq(old_hashed_password)
    end
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
