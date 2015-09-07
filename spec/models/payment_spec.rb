require 'rails_helper'

describe Payment, type: :model do
  it { should belong_to(:order) }
end
