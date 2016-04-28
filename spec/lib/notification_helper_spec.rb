require 'rails_helper'

describe NotificationHelper, type: :lib, integration: true do

    let(:offer) { create(:offer) }

    it 'GCM notification test' do
      response = NotificationHelper.notify({:android => {:token => "/tokens/global", :message => "test"}})
      expect(response[:android]).to include(:status => "success")
    end

    it 'APNS notification test' do
      response = NotificationHelper.notify(:ios => { :destinations => ["3bb34eb96ea6b4330d1c5e3f09af913b71500e7b2ffcb69223809e616fae8e59"], :message => "hi there"})
      expect(response[:ios]).to include(:status => "success")
    end

end
