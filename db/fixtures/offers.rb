images = Image.seed(
  :id,
  {
    id: 1,
    resource: File.open("#{Rails.root}/spec/fixtures/images/image1.jpg")
  },
  {
    id: 2,
    resource: File.open("#{Rails.root}/spec/fixtures/images/image2.jpg")
  },
  {
    id: 3,
    resource: File.open("#{Rails.root}/spec/fixtures/images/image3.jpg")
  },
  {
    id: 4,
    resource: File.open("#{Rails.root}/spec/fixtures/images/image4.jpg")
  },
  {
    id: 5,
    resource: File.open("#{Rails.root}/spec/fixtures/images/image5.jpg")
  },

)

ImageGallery.seed(
  :id,
  {
    id: 1,
    images: [images.first]
  },
  {
    id: 2,
    images: [images.second]
  },
  {
    id: 3,
    images: [images.third]
  },
  {
    id: 4,
    images: [images.fourth]
  },
  {
    id: 5,
    images: [images.fifth]
  },
)

Offer.seed(
  :id,
  {
    id: 1,
    title: 'Cesto degustazione succo di mela e salsa di pomodoro',
    description: 'Lorem ipsum dolor sit amet description Cesto degustazione succo di mela e salsa di pomodoro',
    original_price: nil,
    price: 10.50,
    image_gallery: ImageGallery.first,
    merchant: "A test merchant",
    street: "A street",
    zip_code: "33122",
    city: "Trento (Tn)",
    latitude: "46.0656509",
    longitude: "11.1218342",
    telephone: "0461 898989",
    email: "info@somewhere.com",
    web_site: "http://www.somewhere.com"
  },
  {
    id: 2,
    title: 'Pacco famiglia 6,5 kg di carne di manzo fresca e un omaggio',
    description: 'description Lorem ipsum dolor sit amet Pacco famiglia 6,5 kg di carne di manzo fresca e un omaggio',
    original_price: 185.90,
    price: 84.50,
    image_gallery: ImageGallery.second,
    merchant: "A test merchant",
    street: "A street",
    zip_code: "33122",
    city: "Trento (Tn)",
    latitude: "46.0656509",
    longitude: "11.1218342",
    telephone: "0461 898989",
    email: "info@somewhere.com",
    web_site: "http://www.somewhere.com"
  },
  {
    id: 3,
    title: '1 notte per l’addio al nubilato',
    description: 'description Lorem ipsum dolor sit amet 1 notte per l’addio al nubilato',
    original_price: 200.00,
    price: 140.00,
    image_gallery: ImageGallery.third,
    merchant: "A test merchant",
    street: "A street",
    zip_code: "33122",
    city: "Trento (Tn)",
    latitude: "46.0656509",
    longitude: "11.1218342",
    telephone: "0461 898989",
    email: "info@somewhere.com",
    web_site: "http://www.somewhere.com"
  },
  {
    id: 4,
    title: 'Festa del raccolto 4 notti 2 persone',
    description: 'description Festa del raccolto 4 notti 2 persone Lorem ipsum dolor sit ',
    original_price: 600.00,
    price: 410.00,
    image_gallery: ImageGallery.fourth,
    merchant: "A test merchant",
    street: "A street",
    zip_code: "33122",
    city: "Trento (Tn)",
    latitude: "46.0656509",
    longitude: "11.1218342",
    telephone: "0461 898989",
    email: "info@somewhere.com",
    web_site: "http://www.somewhere.com"
  },
  {
    id: 5,
    title: '2 notti in famiglia',
    description: 'descrip2 notti in famiglia Lorem ipsum dolor sit ',
    original_price: 300.00,
    price: 280.00,
    image_gallery: ImageGallery.fifth,
    merchant: "A test merchant",
    street: "A street",
    zip_code: "33122",
    city: "Trento (Tn)",
    latitude: "46.0656509",
    longitude: "11.1218342",
    telephone: "0461 898989",
    email: "info@somewhere.com",
    web_site: "http://www.somewhere.com"
  },
  {
    id: 6,
    title: 'Degustazione agrodolce con 5 salse e sale aromatizzato',
    description: 'descDegustazione agrodolce con 5 salse e sale aromatizzatosit ',
    original_price: nil,
    price: 26.50,
    merchant: "A test merchant",
    street: "A street",
    zip_code: "33122",
    city: "Trento (Tn)",
    latitude: "46.0656509",
    longitude: "11.1218342",
    telephone: "0461 898989",
    email: "info@somewhere.com",
    web_site: "http://www.somewhere.com"
  },
)
