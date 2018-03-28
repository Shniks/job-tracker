require 'rails_helper'

describe 'User sees all jobs' do
  scenario 'User sees all the jobs for a specific company' do
    company = Company.create!(name: 'ESPN')
    category_1 = Category.create!(name: 'Development')
    category_2 = Category.create!(name: 'Production')
    job_1 = company.jobs.create!(title: 'Developer', level_of_interest: 70, city: 'Denver', category_id: category_1.id)
    job_2 = company.jobs.create!(title: 'QA Analyst', level_of_interest: 70, city: 'New York City', category_id: category_2.id)

    visit company_jobs_path(company)

    expect(page).to have_content("#{company.name}")
    expect(page).to have_content("#{job_1.title}")
    expect(page).to have_content("#{job_2.title}")
  end

  scenario 'User sees all the jobs for a specific location' do
    company = Company.create!(name: 'ESPN')
    category = Category.create!(name: 'Development')
    job_1 = company.jobs.create!(title: 'Developer', level_of_interest: 70, city: 'Denver', category_id: category.id)
    job_2 = company.jobs.create!(title: 'QA Analyst', level_of_interest: 70, city: 'New York City', category_id: category.id)
    job_3 = company.jobs.create!(title: 'QA Analyst I', level_of_interest: 70, city: 'Denver', category_id: category.id)
    job_4 = company.jobs.create!(title: 'QA Analyst II', level_of_interest: 70, city: 'New York City', category_id: category.id)
    job_5 = company.jobs.create!(title: 'QA Analyst II', level_of_interest: 70, city: 'Denver', category_id: category.id)

    visit '/jobs?location=Denver'

    expect(page).to have_content("#{job_1.title}")
    expect(page).to have_content("#{job_3.title}")
    expect(page).to have_content("#{job_5.title}")
  end

  scenario 'User sees all jobs sorted by interest' do
    company = Company.create!(name: 'ESPN')
    category = Category.create!(name: 'Development')
    job_1 = company.jobs.create!(title: 'Developer', level_of_interest: 70, city: 'Denver', category_id: category.id)
    job_2 = company.jobs.create!(title: 'QA Analyst', level_of_interest: 90, city: 'New York City', category_id: category.id)
    job_3 = company.jobs.create!(title: 'QA Analyst I', level_of_interest: 65, city: 'Denver', category_id: category.id)
    job_4 = company.jobs.create!(title: 'QA Analyst II', level_of_interest: 75, city: 'New York City', category_id: category.id)
    job_5 = company.jobs.create!(title: 'QA Analyst II', level_of_interest: 40, city: 'Denver', category_id: category.id)

    visit '/jobs?sort=interest'

    expect(page.first(:xpath, '//ul')).to have_content("#{job_2.level_of_interest}")
  end

  scenario 'User sees all jobs sorted by location' do
    company = Company.create!(name: 'ESPN')
    category = Category.create!(name: 'Development')
    job_1 = company.jobs.create!(title: 'Developer', level_of_interest: 70, city: 'Denver', category_id: category.id)
    job_2 = company.jobs.create!(title: 'QA Analyst', level_of_interest: 90, city: 'New York City', category_id: category.id)
    job_3 = company.jobs.create!(title: 'QA Analyst I', level_of_interest: 65, city: 'Denver', category_id: category.id)
    job_4 = company.jobs.create!(title: 'QA Analyst II', level_of_interest: 75, city: 'New York City', category_id: category.id)
    job_5 = company.jobs.create!(title: 'QA Analyst II', level_of_interest: 40, city: 'Austin', category_id: category.id)

    visit '/jobs?sort=location'

    expect(page.first(:xpath, '//ul')).to have_content("#{job_5.city}")
  end
end
