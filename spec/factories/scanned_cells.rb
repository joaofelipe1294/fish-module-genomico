FactoryBot.define do
  factory :scanned_cell do
    scanning_image { ScanningImage.last }
    analysis_label { :appropriate }
    rgb { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support_images/NUCLEUS.png", 'image/png') }
  end
end
