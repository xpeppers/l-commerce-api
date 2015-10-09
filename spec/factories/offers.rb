FactoryGirl.define do

  factory :offer do
    title "MyString"
    description "MyText"
    original_price nil
    price "9.99"
    merchant
    latitude 'A LATITUDE'
    longitude 'A LONGITUDE'
  end

end
