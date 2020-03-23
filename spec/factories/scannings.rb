FactoryBot.define do
  factory :scanning do
    fish_slice { FishSlice.last }
    responsible_id { Faker::Number.number(digits: 4) }
    responsible_login { Faker::Internet.user_name }
    date { Date.current }
    images { [Rack::Test::UploadedFile.new("#{Rails.root}/spec/support_images/SMALL_PNG_IMAGE.png", 'image/png')] }
  end
end
