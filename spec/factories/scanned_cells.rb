FactoryBot.define do
  factory :scanned_cell do
    scanning_image { ScanningImage.last }
    label { :positive }
  end
end
