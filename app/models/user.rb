class User
  include ActiveModel::Model

  attr_accessor :id, :login

  def self.all
    response = RestClient.get('cda0015.cdapp.net.br:3000/fish-api/users')
    response = JSON.parse response
    response.map { |user| User.new(id: user["id"], login: user["login"])}
  end
end
