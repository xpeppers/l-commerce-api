require 'rails_helper'

describe GcmHelper, type: :lib, integration: true do

    let(:offer) { create(:offer) }

    it 'GCM test' do
      expect(GcmHelper.send_notification(offer)).to include(:code => 200)
    end

end
