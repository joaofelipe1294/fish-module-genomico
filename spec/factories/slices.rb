FactoryBot.define do
  factory :slice do
    responsible_id { 1 }
    responsible_login { "MyString" }
    date { "2020-03-06" }
    subsample_id { 1 }
    subsample_label { "MyString" }
    probe { 1 }
  end
end
