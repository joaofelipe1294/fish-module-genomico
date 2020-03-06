RSpec.configure do |config|

  config.append_before(:each) do
    exams_json = '[{"id":1218,"patient":"Pedro Henrique Pinheiro Theulen","exam":"PAINEL DE ALTERAÇÕES CROMOSSÔMICAS EM LLA POR FISH","sample_id":645,"subsample_label":"20-FISH-0284","status":"Em andamento","started_at":"26/02/2020"},{"id":1213,"patient":"Elton Dimas Corsini","exam":"PESQUISA DA FUSÃO PML-RARA POR FISH","sample_id":641,"subsample_label":"20-FISH-0283","status":"Em andamento","started_at":"21/02/2020"}]'
    stub_request(:get, "cda0015.cdapp.net.br:3000/fish-api/exams").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  # 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  # 'Host'=>'servicodados.ibge.gov.br',
       	  # 'User-Agent'=>'rest-client/2.1.0 (linux-gnu x86_64) ruby/2.6.3p62'
           }).
         to_return(status: 200, body: exams_json, headers: {})
  end

end
