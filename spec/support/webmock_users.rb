RSpec.configure do |config|

  config.append_before(:each) do
    users =   '[{"id":1,"login":"admin"},{"id":15,"login":"andreza.throniecke"},{"id":12,"login":"biomol"},{"id":14,"login":"camila.brey"},{"id":3,"login":"carolina.dias"},{"id":6,"login":"caroline.schenknecht"},{"id":9,"login":"diego.gomes"},{"id":19,"login":"fabiana.poerner"},{"id":8,"login":"fabiola.gevert"},{"id":13,"login":"fish"},{"id":5,"login":"gustavo.costa"},{"id":11,"login":"imunofeno"},{"id":7,"login":"joselito.getz"},{"id":10,"login":"julianne.follador"},{"id":16,"login":"mariah.dondoni"},{"id":17,"login":"nayara.beloto"},{"id":18,"login":"qualidade"},{"id":4,"login":"renata.dourado"},{"id":2,"login":"user"}]'
    # stub_request(:get, "cda0015.cdapp.net.br:3000/fish-api/users").
    #      with(headers: {'Accept'=>'*/*',}).
    #      to_return(status: 200, body: users, headers: {})
    stub_request(:get, "http://cda0015.cdapp.net.br:3000/fish-api/users").
    with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Host'=>'cda0015.cdapp.net.br:3000',
        'User-Agent'=>'rest-client/2.1.0 (linux-gnu x86_64) ruby/2.6.3p62'
      }).
    to_return(status: 200, body: users, headers: {})
  end

end
