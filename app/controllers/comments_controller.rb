class CommentsController < ApplicationController

  def create

    @job = Job.find(params[:job_id])
    company = Company.find(@job.company_id)
    @comment = Comment.create!(content: params[:comment][:content],
    job_id: params[:job_id])
    redirect_to company_job_path(company, @job)
  end
end
