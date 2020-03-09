FactoryBot.define do
  factory :exam do
    name { Faker::Name.name }
    patient { Faker::Name.name }
    subsample_label { Faker::Name.name }
    fish_slice { FishSlice.last }
    start_date { Date.current }
    genomico_exam_id { Faker::Number.number(digits: 3) }
  end
end
