require 'rails_helper'

describe BoughtOffer, type: :model do

  it { should belong_to(:order) }
  it { should belong_to(:offer) }
  it { should have_one(:user).through(:order) }
  it { should have_one(:payment).through(:order) }
  it { should have_one(:coupon).through(:order) }
  it { should have_one(:merchant).through(:offer) }

  it { should define_enum_for(:status) }

end
