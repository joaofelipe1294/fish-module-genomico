FactoryBot.define do
  factory :scanning do
    fish_slice { nil }
    responsible_id { 1 }
    responsible_login { "MyString" }
    date { "2020-03-10" }
  end
end
