FactoryGirl.define do

  factory :offer do
    title "MyString"
    description "MyText"
    original_price nil
    price '9.99'
    row_order 0
    reservation_price '2.00'
    merchant
  end

end
