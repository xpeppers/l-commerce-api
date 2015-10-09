require 'rails_helper'

RSpec.describe "merchants/show", type: :view do
  before(:each) do
    @merchant = assign(:merchant, Merchant.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
