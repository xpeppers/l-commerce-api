require 'rails_helper'

describe Offer, type: :model do

  it { expect(subject).to have_one :image_gallery }
  it { expect(subject).to have_many(:images).through(:image_gallery) }

end
