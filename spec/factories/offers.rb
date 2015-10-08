FactoryGirl.define do

  factory :offer do
    title "MyString"
    description "MyText"
    original_price nil
    price "9.99"
    merchant
    telephone 'A TELEPHONE'
    email 'AN EMAIL'
    web_site 'A WEB SITE'
    street 'A STREET'
    zip_code 'A ZIP CODE'
    city 'A CITY'
    latitude 'A LATITUDE'
    longitude 'A LONGITUDE'
  end

end
