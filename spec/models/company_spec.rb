require 'rails_helper'

describe Company do
  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid without a name' do
        company = Company.new
        expect(company).to be_invalid
      end

      it 'has a unique name' do
        Company.create(name: 'Dropbox')
        company = Company.new(name: 'Dropbox')
        expect(company).to be_invalid
      end
    end

    context 'valid attributes' do
      it 'is valid with a name' do
        company = Company.new(name: 'Dropbox')
        expect(company).to be_valid
      end
    end
  end

  describe 'relationships' do
    it 'has many jobs' do
      company = Company.new(name: 'Dropbox')
      expect(company).to respond_to(:jobs)
    end
  end

  describe 'methods' do
    describe '.by_interest' do
      it 'groups companies by average interest' do
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

        expect(Company.by_interest.first.name).to eq(company.name)
        expect(Company.by_interest.first.average_interest).to eq(90)
      end
    end
  end
end
