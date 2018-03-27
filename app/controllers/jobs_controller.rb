class JobsController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    if sort_params[:sort] == 'location'
      @jobs = Job.sort_by_city
      render :index
    elsif sort_params[:sort] == 'interest'
      @jobs = Job.sort_by_interest
      render :index
    elsif location_params
      @jobs = Job.listing_location(location_params[:location])
    else
      @jobs = @company.jobs
    end
  end

  def new
    @job = Job.new()
  end

  def create
    @company = Company.find(params[:company_id])
    @job = @company.jobs.new(job_params)
    if @job.save
      flash[:success] = "You created #{@job.title} at #{@company.name}"
      redirect_to job_path
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

  def sort_params
    params.permit(:sort)
  end

  def location_params
    params.permit(:location)
  end
end
