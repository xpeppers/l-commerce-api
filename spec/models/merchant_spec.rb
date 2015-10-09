require 'rails_helper'

describe Merchant, type: :model do

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:telephone) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:website) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:city) }
  end
end
