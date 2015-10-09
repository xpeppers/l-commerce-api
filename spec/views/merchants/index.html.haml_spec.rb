require 'rails_helper'

RSpec.describe "merchants/index", type: :view do
  before(:each) do
    assign(:merchants, [
      Merchant.create!(),
      Merchant.create!()
    ])
  end

  it "renders a list of merchants" do
    render
  end
end
