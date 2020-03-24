require 'rails_helper'

RSpec.feature "ScanningImages::Analyzeds", type: :feature do

  describe 'changing a scanning image status from pending to analyzed' do
    before :each do
      create(:fish_slice)
      scanning = create(:scanning)
      @scanning_image = create(:scanning_image)
      NucleusExtractorService.new(@scanning_image).call
      visit scanning_image_path(@scanning_image)
    end
    context "when user is in scanning_image view" do
      context "when scanning_image is pending" do
        it 'is expected to render header informing user that is pending' do
          expect(page).to have_selector '.analyze-image'
        end
        context "when user click in analyzed" do
          before(:each) { click_link class: 'analyze-image', match: :first }
          it 'is expected to render success message' do
            expect(find(id: 'success-message').text).to match I18n.t :scanning_image_analyzed
          end
          it 'is expected to change header message' do
            expect(find(id: 'processing-image-status').text).to match "Imagem já analizada"
          end
          it 'is expected change scanning image to analyzed' do
            expect(@scanning_image.reload.analyzed?).to be_truthy
          end
        end
      end
      context "when scanning_image is analyzed" do
        before :each do
          @scanning_image.update analysis_status: :analyzed
          visit scanning_image_path(@scanning_image)
        end
        it 'is expected to render a header informing that image is pending' do
          expect(find(id: 'processing-image-status').text).to match "Imagem já analizada"
        end
        it 'is expected to no render analyze link' do
          expect(page).not_to have_selector '.analyze-image'
        end
      end
    end
  end

end
