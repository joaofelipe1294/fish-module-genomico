RSpec.configure do |config|

  config.append_before(:each) do
    users =   '[{"id":1,"login":"admin"},{"id":15,"login":"andreza.throniecke"},{"id":12,"login":"biomol"},{"id":14,"login":"camila.brey"},{"id":3,"login":"carolina.dias"},{"id":6,"login":"caroline.schenknecht"},{"id":9,"login":"diego.gomes"},{"id":19,"login":"fabiana.poerner"},{"id":8,"login":"fabiola.gevert"},{"id":13,"login":"fish"},{"id":5,"login":"gustavo.costa"},{"id":11,"login":"imunofeno"},{"id":7,"login":"joselito.getz"},{"id":10,"login":"julianne.follador"},{"id":16,"login":"mariah.dondoni"},{"id":17,"login":"nayara.beloto"},{"id":18,"login":"qualidade"},{"id":4,"login":"renata.dourado"},{"id":2,"login":"user"}]'
    stub_request(:get, "cda0015.cdapp.net.br:3000/fish-api/users").
         with(headers: {'Accept'=>'*/*',}).
         to_return(status: 200, body: users, headers: {})
  end

end
