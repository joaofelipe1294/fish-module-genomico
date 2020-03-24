require 'rails_helper'

RSpec.feature "ScanningImages::Indices", type: :feature do

  before :each do
    fish_slice = create(:fish_slice)
    create(:exam, fish_slice: fish_slice)
    create(:scanning)
    20.times { create(:scanning_image, process_status: :complete, start_processing_at: 10.seconds.ago, finish_processing_at: DateTime.current) }
  end

  describe 'list pending scanning images' do
    context 'when there less more than 15 images' do
      it 'is expected to render all pending images' do
        10.times { ScanningImage.pending.sample.update(analysis_status: :analyzed) }
        visit scanning_images_path({status: 'pending'})
        expect(find_all(class: 'scanning-image').size).to eq 10
      end
    end
    context "when there are more than 15 images" do
      it 'is expected to render 15 images' do
        visit scanning_images_path(status: 'pending')
        expect(find_all(class: 'scanning-image').size).to eq 15
      end
    end
  end

  describe "list analyzed scanning images" do
    context "when there are less than 15 analyzed images" do
      it 'is expected to render all analyzd images' do
        8.times { ScanningImage.pending.sample.update analysis_status: :analyzed }
        visit scanning_images_path(status: :analyzed)
        expect(find_all(class: 'scanning-image').size).to eq 8
      end
    end
    context "when there are more than 15 analyzed images" do
      it 'is expected to render 15 analyzed images' do
        ScanningImage.all.each { |image| image.update analysis_status: :analyzed }
        visit scanning_images_path(status: :analyzed)
        expect(find_all(class: 'scanning-image').size).to eq 15
      end
    end
  end

end
