require 'rails_helper'

describe Order, type: :model do
  it { should have_and_belong_to_many(:offers) }
end
