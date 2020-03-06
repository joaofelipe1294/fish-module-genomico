class SlicesController < ApplicationController
  helper_method :users

  def index
  end

  def new
    @slice = Slice.new({subsample_id: params[:subsample_id], subsample_label: params[:subsample_label]})
  end

  def create
    @slice = Slice.new slice_params
    if @slice.save
      flash[:success] = I18n.t :new_slice_success
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def users
    response = RestClient.get('cda0015.cdapp.net.br:3000/fish-api/users')
    response = JSON.parse response
    response.map { |user| User.new(id: user["id"], login: user["login"])}
  end

  private

    def slice_params
      params.require(:slice).permit(:responsible_id, :responsible_login, :date, :subsample_id, :subsample_label, :probe)
    end

end
