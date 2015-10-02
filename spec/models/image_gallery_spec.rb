require 'rails_helper'

describe ImageGallery, type: :model do
  it { expect(subject).to have_many :images }
end
