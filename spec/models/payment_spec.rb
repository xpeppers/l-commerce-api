require 'rails_helper'

describe Payment, type: :model do
  it { should belong_to(:order) }

  context 'with an authorized paypal payment' do

    let(:user) { create(:user) }
    let(:offer) { create(:offer) }
    let(:order) { create(:order, user: user, offers: [offer]) }
    let(:payment) { create(:payment, paypal_payment_token: 'ANY TOKEN', order: order) }

    it 'captures the payment' do
      expect(PaymentHelper).to receive(:capture_authorized_payment).with('ANY TOKEN').and_return(true)

      payment.capture!

      expect(payment).to be_captured
    end

  end
end
