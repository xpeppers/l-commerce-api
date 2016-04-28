require 'rails_helper'

describe NotificationHelper, type: :lib, integration: true do

    let(:offer) { create(:offer) }

    it 'GCM notification test' do
      expect(NotificationHelper.notify_android("/tokens/stage-generic", {"id" => offer.id, "title" => offer.title})).to include(:status => "success")
    end

    it 'APNS notification test' do
      expect(NotificationHelper.notify_ios(["3bb34eb96ea6b4330d1c5e3f09af913b71500e7b2ffcb69223809e616fae8e59"], "message": "hi there")).to include(:status => "success")
    end

end
