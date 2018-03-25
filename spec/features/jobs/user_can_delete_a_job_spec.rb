require 'rails_helper'

describe 'As a user' do
  describe 'When I delete a job' do
    it 'I can\'t see the job on the company\'s jobs page' do

      company = Company.create!(name: 'ESPN')
      category_1 = Category.create!(name: 'Development')
      category_2 = Category.create!(name: 'Production')

      job_1 = company.jobs.create!(title: 'Developer', level_of_interest: 70, city: 'Denver', category_id: category_1.id)
      job_2 = company.jobs.create!(title: 'Secretary', level_of_interest: 30, city: 'Denver', category_id: category_2.id)

      visit company_job_path(company, job_1)
      click_link 'Delete'

      expect(current_path).to eq("/companies/#{company.id}/jobs")
      expect(page).to_not have_content("#{job_1.title}")
      expect(page).to have_content("#{job_2.title}")
    end
  end
end
