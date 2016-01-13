FactoryGirl.define do
  factory :merchant do
    name 'A NAME'
    description 'A DESCRIPTION'
    telephone 'A TELEPHONE'
    email 'test@email.com'
    hashed_password 'AN HASHED PASSWORD'
    web_site 'A WEB SITE'
    facebook 'A FACEBOOK PAGE URL'
    twitter 'A TWITTER PAGE URL'
    street 'A STREET'
    zip_code 'A ZIP CODE'
    city 'A CITY'
    latitude 46.0667
    longitude 11.1167
  end

end
