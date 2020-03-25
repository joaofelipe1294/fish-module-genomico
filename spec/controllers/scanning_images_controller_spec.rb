require 'rails_helper'
require 'json'

RSpec.describe ScanningImagesController, type: :controller do

  describe "scanning_images?status='processing'" do
    context "when there are images processing" do
      before :each do
        create(:fish_slice)
        create(:scanning)
        5.times { create(:scanning_image, start_processing_at: DateTime.current) }
        ScanningImage.last.update process_status: :complete
      end
      it 'is expected to return ok status' do
        request.env['HTTP_ACCEPT'] = 'application/json'
        get :index, params: {status: 'processing'}
        expect(response).to have_http_status :ok
      end
      it 'is expected to return scanning images list' do
        request.env['HTTP_ACCEPT'] = 'application/json'
        get :index, params: {status: 'processing'}
        expect(JSON.parse(response.body).size).to eq 4
      end
    end
    context "when there is no processing images" do
      it 'is expected to return an empty array' do
        request.env['HTTP_ACCEPT'] = 'application/json'
        get :index, params: { status: 'processing' }
        expect(JSON.parse(response.body).empty?).to be_truthy
      end
    end
  end

end
