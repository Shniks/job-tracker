class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:success] = "#{@company.name} created successfully!"
      redirect_to companies_path
    else
      flash[:failure] = "Sorry, that company name already exists. Please try again!"
      redirect_to new_company_path
    end
  end

  def show
    @company = Company.find(params[:id])
    @contact = Contact.new
    render :show
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    @company.update(company_params)
    if @company.save
      flash[:success] = "#{@company.name} updated successfully!"
      redirect_to companies_path
    else
      render :edit
    end
  end

  def destroy
    company = Company.find(params[:id])
    company.destroy

    flash[:success] = "#{company.name} deleted successfully!"
    redirect_to companies_path
  end

  private

  def company_params
    params.require(:company).permit(:name, :city)
  end
end
