images = Image.seed(
  :id,
  {
    id: 1,
    resource: File.open("#{Rails.root}/spec/fixtures/images/mela1.jpg")
  }
)

Path.seed(
  :id,
  {
    id: 1,
    title: 'Cesto degustazione succo di mela e salsa di pomodoro',
    description: 'Lorem ipsum dolor sit amet description Cesto degustazione succo di mela e salsa di pomodoro',
    image: Image.first
  }
)
