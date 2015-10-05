require 'rails_helper'

describe Offer, type: :model do

  it { expect(subject).to have_one :image_gallery }
  it { expect(subject).to have_many(:images).through(:image_gallery) }

  describe '#image_url' do
    let(:image) { create(:image, resource: File.open("#{Rails.root}/spec/fixtures/images/image.jpg")) }
    let(:image_gallery) { create(:image_gallery, images: [image]) }

    it 'returns the full url of the first image' do
      offer = Offer.create(image_gallery: image_gallery)

      expect(offer.image_url).to eq("http://127.0.0.1:3000/uploads/image/resource/#{image.id}/image.jpg")
    end
  end
end
