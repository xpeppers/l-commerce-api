require 'rails_helper'
require 'backoffice_controller_helper'

describe Backoffice::OffersController, type: :controller do

  include BackofficeControllerHelper

  before do
    authenticate_reseller!
  end

  let(:image) { create :image, resource: File.open("#{Rails.root}/spec/fixtures/images/carne1.jpg") }

  describe 'POST #create' do
    it 'creates an image gallery' do
      expect{
        post :create, offer: {images: [image.id]}
      }.to change(ImageGallery, :count).by(1)
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
      @offer = create :offer
    end

    it 'returns row_order updated' do  
      post :update_row_order, offer_id: @offer.id, id: @offer.id, row_order: 2
      expect(response).to have_http_status(:ok)   
    end
  end
end
