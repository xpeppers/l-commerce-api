require 'rails_helper'

describe Order, type: :model do
  it { should have_many(:bought_offers) }
  it { should have_many(:offers).through(:bought_offers) }
  it { should have_one(:coupon) }
  it { should have_one(:payment) }

  context 'without payment' do
    it "is 'pending'" do
      expect(subject).to be_pending
    end
  end

  context "with 'captured' payment" do
    it "is 'captured'" do
      subject.build_payment(status: 'captured')
      expect(subject).to be_captured
    end
  end
end
