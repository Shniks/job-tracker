require 'rails_helper'

describe 'As a user' do
  describe 'When I delete a job' do
    it 'I can\'t see the job on the company\'s jobs page' do

      company = Company.create!(name: 'ESPN')
      job_1 = company.jobs.create!(title: 'Developer', level_of_interest: 70, city: 'Denver')
      job_2 = company.jobs.create!(title: 'Secretary', level_of_interest: 30, city: 'Denver')

      visit company_job_path(company, job_1)
      click_link 'Delete'

      expect(current_path).to eq("/companies/#{company.id}/jobs")
      expect(page).to_not have_content('Developer')
      expect(page).to have_content('Secretary')
    end
  end
end
