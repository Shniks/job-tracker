class JobsController < ApplicationController
  def index
    if sort_params[:sort] == 'location'
      @jobs = Job.sort_by_city
    elsif sort_params[:sort] == 'interest'
      @jobs = Job.sort_by_interest
    elsif location_params[:location]
      @jobs = Job.listing_location(location_params[:location])
    elsif params[:company_id]
      @company = Company.find(params[:company_id])
      @jobs = @company.jobs
    else
      @jobs = Job.all
    end
    render :index
  end

  def new
    @categories = Category.all
    @companies = Company.all
    @company = Company.find(params[:company_id]) if params[:company_id]
    @job = Job.new()
  end

  def create
    if params[:company_id]
      @company = Company.find(params[:company_id])
      @job = @company.jobs.new(job_params)
    else
      @job = Job.new()
    end
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

  def sort_params
    params.permit(:sort)
  end

  def location_params
    params.permit(:location)
  end
end
