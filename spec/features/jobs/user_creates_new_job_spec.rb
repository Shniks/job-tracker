require 'rails_helper'

describe "User creates a new job" do
  scenario "a user can create a new job" do
    company = Company.create!(name: "ESPN")
    visit new_company_job_path(company)

    fill_in "job[title]", with: "Developer"
    fill_in "job[description]", with: "So fun!"
    fill_in "job[level_of_interest]", with: 80
    fill_in "job[city]", with: "Denver"
    click_button "Save"

    job = company.jobs.last

    expect(current_path).to eq("/companies/#{company.id}/jobs/#{Job.last.id}")
    expect(page).to have_content("#{job.company.name}")
    expect(page).to have_content("#{job.title}")
    expect(page).to have_content("#{job.level_of_interest}")
    expect(page).to have_content("#{job.city}")
  end
end
