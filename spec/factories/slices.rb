FactoryBot.define do
  factory :slice do
    responsible_id { Faker::Number.number }
    responsible_login { Faker::Internet.email }
    date { Date.current }
    subsample_id { Faker::Number.number }
    subsample_label { Faker::Name.name }
    probe { :bcr_abl }
    exam_id { Faker::Number.number }
  end
end
