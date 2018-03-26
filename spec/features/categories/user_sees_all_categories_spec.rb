require 'rails_helper'

describe 'User visits the categories index' do
  scenario 'They can see all categories' do
    category_1 = Category.create!(name: 'Development')
    category_2 = Category.create!(name: 'Production')
    category_3 = Category.create!(name: 'Administrative')

    visit categories_path

    expect(page).to have_content(category_1.name)
    expect(page).to have_content(category_2.name)
    expect(page).to have_content(category_3.name)
  end

  scenario 'They can click edit' do
    category_1 = Category.create!(name: 'Development')

    visit categories_path

    expect(page).to have_link('Edit')
  end

  scenario 'They can click delete' do
    category_1 = Category.create!(name: 'Development')

    visit categories_path
    expect(page).to have_link('Delete')
  end

  scenario 'They can see jobs for each category' do
    company_1 = Company.create!(name: 'ESPN')
    company_2 = Company.create!(name: 'CNN')
    category_1 = Category.create!(name: 'Development')
    category_2 = Category.create!(name: 'Production')
    job_1 = company_1.jobs.create!(title: 'Developer', level_of_interest: 70, city: 'Denver', category_id: category_1.id)
    job_2 = company_1.jobs.create!(title: 'Producer', level_of_interest: 40, city: 'Denver', category_id: category_2.id)
    job_3 = company_1.jobs.create!(title: 'Senior Developer', level_of_interest: 90, city: 'Denver', category_id: category_1.id)

    visit categories_path

    expect(page).to have_link('2 Jobs')
  end
end
