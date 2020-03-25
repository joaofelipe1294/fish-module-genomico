require 'rails_helper'

RSpec.describe ScannedCellsController, type: :controller do

  before :each do
    create(:fish_slice)
    create(:exam)
    scanning = create(:scanning)
    scanning_image = create(:scanning_image)
    NucleusExtractorService.new(scanning_image).call
    @scanned_cell = ScannedCell.last
    request.env['HTTP_ACCEPT'] = 'application/json'
  end

  describe "scanned_cells#update" do
    context "when changing a appropriate cell to inapropriate" do
      before :each do
        patch :update, params: { id: @scanned_cell.id,  label: 'inappropriate' }
      end
      it 'is expected to return ok' do
        expect(response).to have_http_status :ok
      end
      it 'is expected to change cell label to appropriate' do
        expect(@scanned_cell.reload.analysis_label).to match :inappropriate.to_s
      end
    end
    context "when changing cell to inapropriate" do
      before :each do
        @scanned_cell.update analysis_label: :inappropriate
        patch :update, params: {id: @scanned_cell.id, label: 'appropriate' }
      end
      it 'is expected to return ok' do
        expect(response).to have_http_status :ok
      end
      it 'is expected to changed cell label to inappropriate' do
        expect(@scanned_cell.reload.analysis_label).to match :appropriate.to_s
      end
    end

  end

end
