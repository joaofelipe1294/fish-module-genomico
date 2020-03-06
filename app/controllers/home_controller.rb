class HomeController < ApplicationController

  def index
    response = RestClient.get('cda0015.cdapp.net.br:3000/fish-api/exams')
    @exams = JSON.parse response
  end

end
