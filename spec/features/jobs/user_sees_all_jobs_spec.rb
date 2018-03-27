require 'rails_helper'

describe 'User sees all jobs' do
  scenario 'a user sees all the jobs for a specific company' do
    company = Company.create!(name: 'ESPN')
    category_1 = Category.create!(name: 'Development')
    category_2 = Category.create!(name: 'Production')
    job_1 = company.jobs.create!(title: 'Developer', level_of_interest: 70, city: 'Denver', category_id: category_1.id)
    job_2 = company.jobs.create!(title: 'QA Analyst', level_of_interest: 70, city: 'New York City', category_id: category_2.id)

    visit company_jobs_path(company)  

    expect(page).to have_content("#{company.name}")
    expect(page).to have_content("#{job_1.title}")
    expect(page).to have_content("#{job_2.title}")
  end
end
