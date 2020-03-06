class SlicesController < ApplicationController
  helper_method :users

  def index
  end

  def new
    @slice = Slice.new({subsample_id: params[:subsample_id], subsample_label: params[:subsample_label]})
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

end
