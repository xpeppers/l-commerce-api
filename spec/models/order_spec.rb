require 'rails_helper'

describe Order, type: :model do
  it { should have_and_belong_to_many(:offers) }

  it "has 'pending' as default status" do
    expect(subject.pending?).to be true
  end
end
