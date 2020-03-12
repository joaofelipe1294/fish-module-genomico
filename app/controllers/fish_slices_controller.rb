class FishSlicesController < ApplicationController
  helper_method :users

  def index
    @slices = FishSlice.includes(:exam).all.order(date: :desc).page params[:page]
  end

  def new
    @slice = FishSlice.new({genomico_exam_id: params[:exam_id], exam: Exam.new})
  end

  def create
    @slice = FishSlice.new slice_params
    if @slice.save
      flash[:success] = I18n.t :new_fish_slice_success
      redirect_to root_path
    else
      flash[:error] = @slice.errors.full_messages.first
      exam = @slice.exam
      redirect_to new_fish_slice_path(patient: exam.patient, name: exam.name, start_date: exam.start_date, subsample_label: exam.subsample_label, genomico_exam_id: exam.genomico_exam_id)
    end
  end

  def edit
  end

  def show
  end

  def slices_from_exam
    @slices = FishSlice.includes(:exam).where(genomico_exam_id: params[:id])
  end

  def scannings
    @scannings = FishSlice.find(params[:id]).scannings.includes(:fish_slice).order(date: :desc)
  end

  private

    def slice_params
      params.require(:fish_slice).permit(
        :genomico_exam_id,
        :responsible_id,
        :responsible_login,
        :date,
        :subsample_id,
        :subsample_label,
        :probe,
        exam_attributes: [:patient, :name, :start_date, :subsample_label, :genomico_exam_id]
      )
    end

    def exam_params
      {
        name: params[:name],
        patient: params[:patient],
        subsample_label: params[:subsample_label],
        start_date: params[:start_date]
      }
    end

end
