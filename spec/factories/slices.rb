FactoryBot.define do
  factory :slice do
    responsible_id { 1 }
    responsible_login { "MyString" }
    date { "2020-03-05" }
    subsample_id { 1 }
    subsample_label { "MyString" }
  end
end
