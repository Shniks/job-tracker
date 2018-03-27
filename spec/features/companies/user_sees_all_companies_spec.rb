require 'rails_helper'

describe 'User sees all companies' do
  scenario 'they see all the companies' do
    company = Company.create!(name: 'ESPN')
    company_two = Company.create!(name: 'Disney')

    visit companies_path

    expect(page).to have_link('Add a new company')
    expect(page).to have_content("#{company.name}")
    expect(page).to have_content("#{company_two.name}")
  end

end
