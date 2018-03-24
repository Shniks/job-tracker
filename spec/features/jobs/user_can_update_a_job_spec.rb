require 'rails_helper'

describe 'As a user' do
  describe 'When I visit the edit page for a job' do
    it 'I can see all the fields for editing the job' do

      company = Company.create!(name: 'ESPN')
      job = company.jobs.create!(title: 'Developer', level_of_interest: 70, city: 'Denver')

      visit company_job_path(company, job)
      click_link 'Edit'

      expect(current_path).to eq("/companies/#{company.id}/jobs/#{job.id}/edit")
      # expect(page).to have_content('Category')
      expect(page).to have_content('Title')
      expect(page).to have_content('Company')
      expect(page).to have_content('City')
      expect(page).to have_content('Description')
      expect(page).to have_content('Level of interest')
      expect(page).to have_link('Cancel')
      expect(page).to have_button('Save')
    end

    it 'I can submit changes to a job' do
      company_1 = Company.create!(name: 'ESPN')
      company_2 = Company.create!(name: 'CNN')
      job = company_1.jobs.create!(title: 'Developer', level_of_interest: 70, city: 'Denver')

      visit edit_company_job_path(company_1, job)

      fill_in('job[title]', with: 'Developer 2.0')
      fill_in('job[city]', with: 'Boulder')
      fill_in('job[description]', with: 'This is a different job')
      fill_in('job[level_of_interest]', with: 45)
      click_button('Save')

      expect(current_path).to eq("/companies/#{company_1.id}/jobs/#{job.id}")
      expect(page).to have_content('Developer 2.0')
      expect(page).to have_content('ESPN')
      expect(page).to_not have_content('CNN')
      expect(page).to have_content('Boulder')
      expect(page).to have_content('This is a different job')
      expect(page).to have_content('45')
    end
  end
end
