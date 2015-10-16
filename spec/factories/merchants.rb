FactoryGirl.define do
  factory :merchant do
    name "a string"
    telephone 'A TELEPHONE'
    email 'AN EMAIL'
    hashed_password 'AN HASHED PASSWORD'
    web_site 'A WEB SITE'
    street 'A STREET'
    zip_code 'A ZIP CODE'
    city 'A CITY'
    latitude 46.0667
    longitude 11.1167
  end

end
