class JobsController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    @jobs = @company.jobs
  end

  def new
    @job = Job.new()
    @categories = Category.all
    @companies = Company.all
    @company = Company.find(params[:company_id])
  end

  def create
    @company = Company.find(params[:company_id])
    @job = @company.jobs.new(job_params)
    if @job.save
      flash[:success] = "You created #{@job.title} at #{@company.name}"
      redirect_to company_jobs_path
    else
      render :new
    end
  end

  def show
    @job = Job.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @job = Job.find(params[:id])
    @categories = Category.all
    @companies = Company.all
  end

  def update
    @job = Job.find(params[:id])
    @job.update(job_params)
    if @job.save
      flash[:success] = "#{@job.title} updated!"
      redirect_to job_path
    else
      render :edit
    end
  end

  def destroy
    job = Job.find(params[:id])
    company = Company.find(job.company_id)

    job.destroy
    redirect_to company_jobs_path(company)
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :city, :category_id, :company_id)
  end
end
