FactoryGirl.define do

  factory :offer do
    title "MyString"
    description "MyText"
    original_price nil
    price "9.99"
    image_url "MyString"
    merchant 'A MERCHANT'
  end

end
