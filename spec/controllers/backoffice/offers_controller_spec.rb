require 'rails_helper'
require 'backoffice_controller_helper'

describe Backoffice::OffersController, type: :controller do

  include BackofficeControllerHelper

  before do
    authenticate_reseller!
  end

  let(:image) { create :image, resource: File.open("#{Rails.root}/spec/fixtures/images/carne1.jpg") }

  describe 'POST #create' do
    before do
      @merchant = create :merchant
      @offer = build :offer, merchant: @merchant
    end

    it 'creates an image gallery' do
      expect{
        post :create, offer: {images: [image.id]}
      }.to change(ImageGallery, :count).by(1)
    end


    it 'gives highest order priority to the last offer created' do  
      post :create, offer: {title: "title", description: "anything", price: 1, reservation_price: 1, merchant_id: @merchant.id}
      first_offer = Offer.last
      expect(first_offer.row_order).to be(0)

      post :create, offer: {title: "another title", description: "anything", price: 1, reservation_price: 1, merchant_id: @merchant.id}
      second_offer = Offer.last
      expect(first_offer.reload.row_order).to be(1)
      expect(second_offer.row_order).to be(0)
    end
  end

  describe 'PUT #update' do

    context 'with an image gallery' do
      let(:image_gallery) { create :image_gallery, images: [image] }
      let(:offer) { create :offer, image_gallery: image_gallery }

      let(:another_image) { create :image, resource: File.open("#{Rails.root}/spec/fixtures/images/carne1.jpg") }

      it 'updates the image gallery' do
        put :update, id: offer.id, offer: {images: [image.id, another_image.id]}

        expect(offer.images).to have(2).images
      end
    end

    context 'without a image gallery' do
      let(:offer) { create :offer }

      it 'creates the image gallery' do
        put :update, id: offer.id, offer: {images: [image.id]}

        expect(offer.images).to have(1).images
      end
    end

  end



  describe 'POST #update_row_order' do 
    before do
      @merchant = create :merchant
      @offer = build :offer, merchant: @merchant
    end

    it 'updates highest order priority for the specified offer and the others if neccessary' do  
      post :create, offer: {title: "title", description: "anything", price: 1, reservation_price: 1, merchant_id: @merchant.id}
      first_offer = Offer.last  
      post :create, offer: {title: "another title", description: "anything", price: 1, reservation_price: 1, merchant_id: @merchant.id}
      second_offer = Offer.last
      post :create, offer: {title: "another title", description: "anything", price: 1, reservation_price: 1, merchant_id: @merchant.id}
      third_offer = Offer.last
      expect(first_offer.reload.row_order).to be(2)
      expect(second_offer.reload.row_order).to be(1)
      expect(third_offer.row_order).to be(0)

      post :update_row_order, offer_id: first_offer.id, id: first_offer.id, row_order: 0
      expect(first_offer.reload.row_order).to be(0)
      expect(second_offer.reload.row_order).to be(2)
      expect(third_offer.reload.row_order).to be(1)
    end
  end
end
