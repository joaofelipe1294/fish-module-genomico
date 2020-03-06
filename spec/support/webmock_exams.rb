RSpec.configure do |config|

  config.append_before(:each) do
    exams_json = '[{"id":1218,"patient":"Pedro Henrique Pinheiro Theulen","exam":"PAINEL DE ALTERAÇÕES CROMOSSÔMICAS EM LLA POR FISH","sample_id":645,"subsample_label":"20-FISH-0284","status":"Em andamento","started_at":"26/02/2020"},{"id":1213,"patient":"Elton Dimas Corsini","exam":"PESQUISA DA FUSÃO PML-RARA POR FISH","sample_id":641,"subsample_label":"20-FISH-0283","status":"Em andamento","started_at":"21/02/2020"}]'
    stub_request(:get, "cda0015.cdapp.net.br:3000/fish-api/exams").
         with(headers: {'Accept'=>'*/*',}).
         to_return(status: 200, body: exams_json, headers: {})
  end

end
