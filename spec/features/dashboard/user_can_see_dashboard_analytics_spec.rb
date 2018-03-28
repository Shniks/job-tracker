require 'rails_helper'

describe 'User visits dashboard' do
  scenario 'They see top 3 companies by interest' do
    company = Company.create!(name: 'PBS')
    category_1 = Category.create!(name: 'Development')
    company.jobs.create!(title: 'Senior Dev', level_of_interest: 90, city: 'Denver', category_id: category_1.id)
    company.jobs.create!(title: 'Junior Dev', level_of_interest: 90, city: 'Denver', category_id: category_1.id)
    company.jobs.create!(title: 'Baby Dev', level_of_interest: 90, city: 'Denver', category_id: category_1.id)

    company_2 = Company.create!(name: 'Aetna')
    category_2 = Category.create!(name: 'Health Care')
    company_2.jobs.create!(title: 'Doctor', level_of_interest: 80, city: 'Denver', category_id: category_2.id)
    company_2.jobs.create!(title: 'Nurse', level_of_interest: 80, city: 'Denver', category_id: category_2.id)

    company_3  = Company.create!(name: 'Crocs')
    category_3 = Category.create!(name: 'Retail')
    company_3.jobs.create!(title: 'Call Service Rep', level_of_interest: 30, city: 'Denver', category_id: category_3.id)
    company_3.jobs.create!(title: 'Floor clerk', level_of_interest: 30, city: 'Denver', category_id: category_3.id)

    company_4 = Company.create!(name: 'IBM')
    category_4 = Category.create!(name: 'Quality Assurance')
    company_4.jobs.create!(title: 'Duty Manager', level_of_interest: 10, city: 'Denver', category_id: category_4.id)
    company_4.jobs.create!(title: 'VP', level_of_interest: 10, city: 'Denver', category_id: category_4.id)


    visit root_path

    expect(page).to have_content(company.name)
    expect(page).to have_content("90")
    expect(page).to have_content(company_2.name)
    expect(page).to have_content("80")
    expect(page).to have_content(company_3.name)
    expect(page).to have_content("30")
  end

  scenario 'They see a count of jobs by level of interest' do
    company = Company.create!(name: 'PBS')
    category_1 = Category.create!(name: 'Development')
    company.jobs.create!(title: 'Senior Dev', level_of_interest: 90, city: 'Denver', category_id: category_1.id)
    company.jobs.create!(title: 'Junior Dev', level_of_interest: 90, city: 'Denver', category_id: category_1.id)
    company.jobs.create!(title: 'Baby Dev', level_of_interest: 90, city: 'Denver', category_id: category_1.id)
    company.jobs.create!(title: 'Game Dev', level_of_interest: 30, city: 'Denver', category_id: category_1.id)
    company.jobs.create!(title: 'Cup Dev', level_of_interest: 30, city: 'Denver', category_id: category_1.id)
    company.jobs.create!(title: 'Glove Dev', level_of_interest: 30, city: 'Denver', category_id: category_1.id)
    company.jobs.create!(title: 'Phone Dev', level_of_interest: 20, city: 'Denver', category_id: category_1.id)
    company.jobs.create!(title: 'Keys Dev', level_of_interest: 20, city: 'Denver', category_id: category_1.id)
    company.jobs.create!(title: 'Pen Dev', level_of_interest: 10, city: 'Denver', category_id: category_1.id)

    visit root_path

    expect(page).to have_content ('90 (3 jobs)')
    expect(page).to have_content ('30 (3 jobs)')
    expect(page).to have_content ('20 (2 jobs)')
    expect(page).to have_content ('10 (1 jobs)')
  end

  scenario 'They see a count of jobs by location' do
    company = Company.create!(name: 'PBS')
    category_1 = Category.create!(name: 'Development')
    company.jobs.create!(title: 'Senior Dev', level_of_interest: 90, city: 'Denver', category_id: category_1.id)
    company.jobs.create!(title: 'Junior Dev', level_of_interest: 90, city: 'Denver', category_id: category_1.id)
    company.jobs.create!(title: 'Baby Dev', level_of_interest: 90, city: 'Denver', category_id: category_1.id)
    company.jobs.create!(title: 'Game Dev', level_of_interest: 30, city: 'Denver', category_id: category_1.id)
    company.jobs.create!(title: 'Cup Dev', level_of_interest: 30, city: 'Denver', category_id: category_1.id)
    company.jobs.create!(title: 'Glove Dev', level_of_interest: 30, city: 'Boulder', category_id: category_1.id)
    company.jobs.create!(title: 'Phone Dev', level_of_interest: 20, city: 'Boulder', category_id: category_1.id)
    company.jobs.create!(title: 'Keys Dev', level_of_interest: 20, city: 'Boulder', category_id: category_1.id)
    company.jobs.create!(title: 'Pen Dev', level_of_interest: 10, city: 'Boulder', category_id: category_1.id)

    visit root_path

    expect(page).to have_link('Denver jobs')
    expect(page).to have_content('Denver jobs (5 jobs)')
    expect(page).to have_link('Boulder jobs')
    expect(page).to have_content('Boulder jobs (4 jobs)')
  end
end
