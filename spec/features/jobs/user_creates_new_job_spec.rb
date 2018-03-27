require 'rails_helper'

describe 'User creates a new job' do
  scenario 'a user can create a new job' do
    company = Company.create!(name: 'ESPN')
    category_1 = Category.create!(name: 'Development')
    category_2 = Category.create!(name: 'Production')

    visit new_company_job_path(company)

    select 'Development', from: 'job[category_id]'
    fill_in 'job[title]', with: 'Developer'
    select 'ESPN', from: 'job[company_id]'
    fill_in 'job[description]', with: 'So fun!'
    fill_in 'job[level_of_interest]', with: 80
    fill_in 'job[city]', with: 'Denver'

    click_button 'Save'

    job = company.jobs.last

    expect(current_path).to eq(company_jobs_path(company))
    save_and_open_page
    expect(page).to have_content("#{job.company.name}")
    expect(page).to have_content("#{job.title}")
  end
end
