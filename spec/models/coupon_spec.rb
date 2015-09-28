require 'rails_helper'

describe Coupon, type: :model do

  describe "#code" do
    before do
      subject.save
    end

    it 'generates a random 6 digits code' do
      expect(subject.code).to be_eql('786546')
    end
  end

end
