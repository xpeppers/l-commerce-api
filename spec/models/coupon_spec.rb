require 'rails_helper'

describe Coupon, type: :model do

  describe "#code" do
    it 'when created a random 6 digits code is generated' do
      coupon = create(:coupon)

      expect(coupon.code).to match(/^[0-9]{6}$/)
    end
  end

end
