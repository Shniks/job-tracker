require 'rails_helper'

describe 'User visits the company path' do
  describe 'They click on delete icon for a job' do
    it 'They can\'t see the job on the company\'s jobs page' do

      company = Company.create!(name: 'ESPN')
      category_1 = Category.create!(name: 'Development')
      category_2 = Category.create!(name: 'Production')

      job_1 = company.jobs.create!(title: 'Developer', level_of_interest: 70, city: 'Denver', category_id: category_1.id)

      visit company_path(company)

       click_link 'Delete'

      expect(current_path).to eq(company_path(company))
      expect(page).to_not have_content("#{job_1.title}")
    end
  end
end
