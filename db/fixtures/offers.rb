merchant = Merchant.seed(
  :id,
  {
    id: 1,
    name: 'A test merchant',
    street: "A street",
    zip_code: "33122",
    city: "Trento (Tn)",
    telephone: "0461 898989",
    email: "info@somewhere.com",
    web_site: "http://www.somewhere.com",
    latitude: 46.0656509,
    longitude: 11.1218342
  }
)

images = Image.seed(
  :id,
  {
    id: 1,
    resource: File.open("#{Rails.root}/spec/fixtures/images/mela1.jpg")
  },
  {
    id: 2,
    resource: File.open("#{Rails.root}/spec/fixtures/images/mela2.jpg")
  },
  {
    id: 3,
    resource: File.open("#{Rails.root}/spec/fixtures/images/carne1.jpg")
  },
  {
    id: 4,
    resource: File.open("#{Rails.root}/spec/fixtures/images/carne2.jpg")
  },
  {
    id: 5,
    resource: File.open("#{Rails.root}/spec/fixtures/images/nubilato1.jpg")
  },
  {
    id: 6,
    resource: File.open("#{Rails.root}/spec/fixtures/images/nubilato2.jpg")
  },
  {
    id: 7,
    resource: File.open("#{Rails.root}/spec/fixtures/images/cereda1.jpg")
  },
  {
    id: 8,
    resource: File.open("#{Rails.root}/spec/fixtures/images/cereda2.jpg")
  },
  {
    id: 9,
    resource: File.open("#{Rails.root}/spec/fixtures/images/cereda3.jpg")
  },
  {
    id: 10,
    resource: File.open("#{Rails.root}/spec/fixtures/images/cereda4.jpg")
  }
)

ImageGallery.seed(
  :id,
  {
    id: 1,
    images: [images[0], images[1]]
  },
  {
    id: 2,
    images: [images[2], images[3]]
  },
  {
    id: 3,
    images: [images[4], images[5]]
  },
  {
    id: 4,
    images: [images[6], images[7], images[8], images[9]]
  }
)

Offer.seed(
  :id,
  {
    id: 1,
    title: 'Cesto degustazione succo di mela e salsa di pomodoro',
    description: 'Lorem ipsum dolor sit amet description Cesto degustazione succo di mela e salsa di pomodoro',
    original_price: nil,
    price: 0.01,
    image_gallery: ImageGallery.first,
    merchant: Merchant.first
  },
  {
    id: 2,
    title: 'Pacco famiglia 6,5 kg di carne di manzo fresca e un omaggio',
    description: 'Lorem ipsum dolor sit amet Pacco famiglia 6,5 kg di carne di manzo fresca e un omaggio',
    original_price: 185.90,
    price: 84.50,
    image_gallery: ImageGallery.second,
    merchant: Merchant.first
  },
  {
    id: 3,
    title: '1 notte per l’addio al nubilato',
    description: 'Lorem ipsum dolor sit amet 1 notte per l’addio al nubilato',
    original_price: 200.00,
    price: 140.00,
    image_gallery: ImageGallery.third,
    merchant: Merchant.first
  },
  {
    id: 4,
    title: 'Festa del raccolto 4 notti 2 persone',
    description: 'Festa del raccolto 4 notti 2 persone Lorem ipsum dolor sit ',
    original_price: 600.00,
    price: 410.00,
    image_gallery: nil,
    merchant: Merchant.first
  },
  {
    id: 5,
    title: '2 notti in famiglia',
    description: '2 notti in famiglia Lorem ipsum dolor sit ',
    original_price: 300.00,
    price: 280.00,
    image_gallery: nil,
    merchant: Merchant.first
  },
  {
    id: 6,
    title: 'Degustazione agrodolce con 5 salse e sale aromatizzato: Agritur Dalaip Dei Pape',
    description: '5 conserve e 1 confezione di sale aromatizzato del mediterraneo per degustare i sapori dell’agriturismo. Ottime per accompagnare selvaggina, bolliti, formaggi, salumi e verdure alla griglia. Acquista l’offerta online e ritira i prodotti direttamente all’agritur Dalaip dei Pape a Todanico. Agriturismo Dalaip dei Pape',
    original_price: nil,
    price: 26.50,
    merchant: Merchant.first,
    image_gallery: ImageGallery.fourth
  },
)
