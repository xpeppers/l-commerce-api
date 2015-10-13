require 'rails_helper'

describe Backoffice::OffersController, type: :controller do

  before(:each) do
    username = BACKOFFICE['username']
    password = BACKOFFICE['password']
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
  end

  describe 'POST #create' do
    let(:image) { create :image, resource: File.open("#{Rails.root}/spec/fixtures/images/carne1.jpg") }

    it 'creates an image gallery' do
      expect{
        post :create, offer: {images: [image.id]}
      }.to change(ImageGallery, :count).by(1)
    end
  end

  describe 'PUT #update' do

    context 'with an image gallery' do
      let(:image) { create :image, resource: File.open("#{Rails.root}/spec/fixtures/images/carne1.jpg") }
      let(:image_gallery) { create :image_gallery, images: [image] }
      let(:offer) { create :offer, image_gallery: image_gallery }

      let(:another_image) { create :image, resource: File.open("#{Rails.root}/spec/fixtures/images/carne1.jpg") }

      it 'updates the image gallery' do
        put :update, id: offer.id, offer: {images: [image.id, another_image.id]}

        expect(offer.images).to have(2).images
      end
    end

    context 'without a image gallery' do
      let(:image) { create :image, resource: File.open("#{Rails.root}/spec/fixtures/images/carne1.jpg") }
      let(:offer) { create :offer }

      it 'creates the image gallery' do
        put :update, id: offer.id, offer: {images: [image.id]}

        expect(offer.images).to have(1).images
      end
    end

  end
end
