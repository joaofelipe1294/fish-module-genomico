FactoryBot.define do
  factory :scanning_image do
    scanning { Scanning.last }
    total_nucleus_found { Faker::Number.number(digits: 3) }
    valid_nucleus_found { Faker::Number.number(digits: 3) }
  end
end
