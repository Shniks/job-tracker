class ContactsController < ApplicationController
  def create
    @company = Company.find(params[:company_id])
    @contact = Contact.create!(name: params[:contact][:name],
                               position: params[:contact][:position],
                               email: params[:contact][:email],
                               company_id: params[:company_id])
    redirect_to company_path(@company)
  end
end
