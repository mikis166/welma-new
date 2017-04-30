class CandidatesController < ApplicationController

  def new
    @job = Job.find_by_id(params[:job_id])
    @candidate = @job.candidates.new
  end

  def create
    @candidate = Candidate.new(candidate_params.merge(:profile_id => current_user.profile.id))

    if @candidate.save
      flash[:notice] = "Application successful!"
      redirect_to job_url(@candidate.job.id)
    else
      @job = @candidate.job
      render :new
    end

  end

private

  def candidate_params
    params.require(:candidate).permit(:cv, :description, :job_id)
  end
end
