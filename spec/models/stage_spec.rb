require 'rails_helper'

describe Stage, type: :model do

  context 'association' do
    it { should belong_to(:image) }
    it { should belong_to(:merchant) }
    it { should belong_to(:path) }
  end

  context 'validation' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:image) }
    it { should validate_presence_of(:path) }
  end
end
