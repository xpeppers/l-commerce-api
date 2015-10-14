require 'rails_helper'

describe Offer, type: :model do

  it { should have_one :image_gallery }
  it { should have_many(:images).through(:image_gallery) }
  it { should belong_to(:merchant) }

  it { should validate_presence_of(:merchant) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:price) }

  describe '#image_url' do
    let(:image) { create(:image, resource: File.open("#{Rails.root}/spec/fixtures/images/carne1.jpg")) }
    let(:image_gallery) { create(:image_gallery, images: [image]) }

    it 'returns the full url of the first image' do
      offer = create(:offer, image_gallery: image_gallery)

      expect(offer.image_url).to eq("http://127.0.0.1:3000/uploads/image/resource/#{image.id}/carne1.jpg")
    end
  end
end
