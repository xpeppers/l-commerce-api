require 'rails_helper'

describe Coupon, type: :model do

  describe "#code" do
    before do
      subject.save
    end

    it 'generates a random 6 digits code' do
      expect(subject.code).to match(/^[0-9]{6}$/)
    end
  end

end
