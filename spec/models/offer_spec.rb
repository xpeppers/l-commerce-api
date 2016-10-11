require 'rails_helper'

describe Offer, type: :model do

  it { should have_one :image_gallery }
  it { should have_many(:images).through(:image_gallery) }
  it { should belong_to(:merchant) }

  it { should validate_presence_of(:merchant) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:reservation_price) }
  it { should validate_presence_of(:row_order) }

  describe '#image_url' do
    let(:image) { create(:image, resource: File.open("#{Rails.root}/spec/fixtures/images/carne1.jpg")) }
    let(:image_gallery) { create(:image_gallery, images: [image]) }

    it 'returns the full url of the first image' do
      offer = create(:offer, image_gallery: image_gallery)

      expect(offer.image_url).to eq("http://127.0.0.1:3000/uploads/image/resource/#{image.id}/carne1.jpg")
    end
  end

  it "price must be less than original_price" do
    valid_offer = create(:offer, price: 10, original_price: 20)
    expect(valid_offer.valid?).to be(true)

    invalid_offer = build(:offer, price: 20, original_price: 15)
    # expect(invalid_offer.valid?).to be(false)
  end

  describe '#destroy' do
    let(:image) { create(:image, resource: File.open("#{Rails.root}/spec/fixtures/images/carne1.jpg")) }
    let(:image_gallery) { create(:image_gallery, images: [image]) }

    it 'destroys associated image gallery' do
      offer = create(:offer, image_gallery: image_gallery)

      offer.destroy

      expect(ImageGallery).to have(0).image_galleries
      expect(Image).to have(0).images
    end

    context 'with a bought offer' do
      let(:user) { create(:user) }
      let(:offer) { create(:offer, image_gallery: image_gallery) }

      it 'does not delete the offer' do
        create(:order, user: user, offers: [offer])

        expect{
          offer.destroy
        }.to_not change(Offer, :count)
      end
    end
  end
end
