require 'rails_helper'

describe Path, type: :model do

  context 'validation' do
    it { should belong_to(:image) }

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:image) }
  end
end
