class HomeController < ApplicationController

  def index
    response = RestClient.get('cda0015.cdapp.net.br:3000/fish-api/exams')
    @exams = JSON.parse(response).map do |exam|
      Exam.new({
        exam: exam["exam"],
        patient: exam["patient"],
        subsample_label: exam["subsample_label"],
        started_at: exam["started_at"],
        status: exam["status"],
        sample_id: exam["sample_id"],
        subsample_label: exam["subsample_label"],
        id: exam["id"]
      })
    end
  end

end
