class User
  include ActiveModel::Model

  attr_accessor :id, :login

  def self.all
    begin
      response = RestClient.get('http://cda0015.cdapp.net.br:3000/fish-api/users')
    rescue
      data = [{"id": 2, "login": 'azuka'}].to_json
      response = data if Rails.env == "development" or Rails.env == "test"
    end
    response = JSON.parse response
    response.map { |user| User.new(id: user["id"], login: user["login"])}
  end
end
