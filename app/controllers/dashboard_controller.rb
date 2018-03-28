class DashboardController < ApplicationController

  def index
    @jobs_by_interest = Job.group_by_interest
    @jobs_by_location = Job.group_by_location
    @top_companies = Company.by_interest
  end
end
