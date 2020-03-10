FactoryBot.define do
  factory :fish_slice do
    responsible_id { Faker::Number.number(digits: 4) }
    responsible_login { Faker::Internet.email }
    date { Date.current }
    subsample_id { Faker::Number.number(digits: 4) }
    subsample_label { Faker::Name.name }
    probe { :bcr_abl }
    genomico_exam_id { Faker::Number.number(digits: 4) }
  end
end
