FactoryBot.define do
  factory :scanning_image do
    scanning { Scanning.last }
    total_nucleus_found { Faker::Number.number(digits: 3) }
    valid_nucleus_found { Faker::Number.number(digits: 3) }
    original { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support_images/SMALL_PNG_IMAGE.png", 'image/png') }
  end
end
