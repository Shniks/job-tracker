require 'rails_helper'

describe 'User visits edit page for a job' do
    it 'They can see all the fields for editing the job' do

      company = Company.create!(name: 'ESPN')
      category_1 = Category.create!(name: 'Development')
      category_2 = Category.create!(name: 'Production')
      job = company.jobs.create!(title: 'Developer', level_of_interest: 70, city: 'Denver', category_id: category_1.id)

      visit job_path(job)
      click_link 'Edit'

      expect(current_path).to eq(edit_job_path(job))
      expect(page).to have_content('Category')
      expect(page).to have_content('Title')
      expect(page).to have_content('Company')
      expect(page).to have_content('City')
      expect(page).to have_content('Description')
      expect(page).to have_content('Level of interest')
      expect(page).to have_link('Cancel')
      expect(page).to have_button('Save')
    end

    it 'They can submit changes to a job' do
      company_1 = Company.create!(name: 'ESPN')
      company_2 = Company.create!(name: 'CNN')
      category_1 = Category.create!(name: 'Development')
      category_2 = Category.create!(name: 'Production')
      job = company_1.jobs.create!(title: 'Developer', level_of_interest: 70, city: 'Denver', category_id: category_1.id)

      visit edit_job_path(job)

      fill_in('job[title]', with: 'Developer 2.0')
      fill_in('job[city]', with: 'Boulder')
      fill_in('job[description]', with: 'This is a different job')
      fill_in('job[level_of_interest]', with: 45)
      click_button('Save')

      expect(current_path).to eq(job_path(job))
      expect(page).to have_content('Developer 2.0')
      expect(page).to have_content('ESPN')
      expect(page).to_not have_content('CNN')
      expect(page).to have_content('Boulder')
      expect(page).to have_content('This is a different job')
      expect(page).to have_content('45')
    end
end
