require 'rails_helper'

describe ImageGallery, type: :model do
  it { expect(subject).to have_many :images }

  describe "#add" do
    it "adds an image" do
      image_gallery = create(:image_gallery)
      image_asset = create(:image_asset)

      image_gallery.add(image_asset)

      expect(image_gallery.images).to have(1).image
    end
  end

end
