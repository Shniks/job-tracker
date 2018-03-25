require 'rails_helper'

describe "User sees a specific job" do
  scenario "a user sees a job for a specific company" do
    company = Company.create!(name: "ESPN")
    category_1 = Category.create!(name: 'Development')
    category_2 = Category.create!(name: 'Production')
    job = company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver", category_id: category_1.id)

    visit company_job_path(company, job)

    expect(page).to have_content("#{job.company.name}")
    expect(page).to have_content("#{job.title}")
    expect(page).to have_content("#{job.level_of_interest}")
  end
end
