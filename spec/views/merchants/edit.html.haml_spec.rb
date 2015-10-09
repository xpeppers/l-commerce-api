require 'rails_helper'

RSpec.describe "merchants/edit", type: :view do
  before(:each) do
    @merchant = assign(:merchant, Merchant.create!())
  end

  it "renders the edit merchant form" do
    render

    assert_select "form[action=?][method=?]", merchant_path(@merchant), "post" do
    end
  end
end
