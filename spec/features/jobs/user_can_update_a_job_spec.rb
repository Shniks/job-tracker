require 'rails_helper'

describe 'As a user' do
  describe 'When I visit the edit page for a job' do
    it 'I can see all the fields for editing the job' do

      company = Company.create!(name: "ESPN")
      job = company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver")

      visit "/companies/#{company.id}/jobs/#{job.id}"
      click_link "Edit"

      expect(current_path).to eq("/companies/#{company.id}/jobs/#{job.id}/edit")
      # expect(page).to have_content('Category')
      expect(page).to have_content('Title')
      expect(page).to have_content('Company') #Check if this is needed and if yes, grey it out
      expect(page).to have_content('City')
      expect(page).to have_content('Description')
      expect(page).to have_content('Level of interest')
      expect(page).to have_link('Cancel')
      expect(page).to have_button('Save')
    end
  end
end
