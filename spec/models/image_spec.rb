require 'rails_helper'

describe Image, type: :model do

  it { expect(subject).to have_one :image_asset }

end
