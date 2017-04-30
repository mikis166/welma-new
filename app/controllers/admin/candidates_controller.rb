class Admin::CandidatesController < Admin::BaseController

  def index
    @job = Job.includes(:candidates).find_by_id(params[:job_id])
    @candidates = @job.candidates
  end
end
