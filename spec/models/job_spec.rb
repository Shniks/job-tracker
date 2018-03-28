require 'rails_helper'

describe Job do
  describe 'Validations' do
    context 'Invalid attributes' do
      it 'Is invalid without a title' do
        job = Job.new(level_of_interest: 80, description: 'Wahoo', city: 'Denver')
        expect(job).to be_invalid
      end

      it 'Is invalid without a level of interest' do
        job = Job.new(title: 'Developer', description: 'Wahoo', city: 'Denver')
        expect(job).to be_invalid
      end

      it 'Is invalid without a city' do
        job = Job.new(title: 'Developer', description: 'Wahoo', level_of_interest: 80)
        expect(job).to be_invalid
      end
    end

    context 'Valid attributes' do
      it 'Is valid with a title, level of interest, company and category' do
        company = Company.new(name: 'Turing')
        category = Category.create!(name: 'Development')
        job = Job.new(title: 'Developer', level_of_interest: 40, city: 'Denver', company: company, category: category)
        expect(job).to be_valid
      end
    end
  end

  describe 'Relationships' do
    it 'Belongs to a company' do
      job = Job.new(title: 'Software', level_of_interest: 70, description: 'Wahooo')
      expect(job).to respond_to(:company)
    end

    it 'Belongs to a category' do
      job = Job.new(title: 'Software', level_of_interest: 70, description: 'Wahooo')
      expect(job).to respond_to(:category)
    end
  end

  describe 'Methods' do
    describe '.sorted_comments' do
      it 'Sorts comments in reverse chronological order' do
        company = Company.create!(name: 'ESPN')
        category = Category.create!(name: 'Production')
        job = Job.create!(title: 'Manager', level_of_interest: 80, description: 'Wahoo', city: 'Denver', company: company, category: category)
        comment_1 = Comment.create!(content: 'This seems like a good job', job: job)
        comment_2 = Comment.create!(content: 'Actually, this doesn\'t seem like a good job', job: job)
        comment_3 = Comment.create!(content: 'Avoid this job', job: job)

        expect(job.sorted_comments.first.content).to eq(comment_3.content)
      end
    end

    describe '.sort_by_city' do
      it 'Sorts city in chronological order' do
        company = Company.create!(name: 'ESPN')
        category = Category.create!(name: 'Production')
        job_1 = Job.create!(title: 'Manager 1', level_of_interest: 60, description: 'Wahoo', city: 'Denver', company: company, category: category)
        job_2 = Job.create!(title: 'Manager 2', level_of_interest: 70, description: 'Wahoo', city: 'Bakersfield', company: company, category: category)
        job_3 = Job.create!(title: 'Manager 3', level_of_interest: 80, description: 'Wahoo', city: 'Austin', company: company, category: category)

        expect(Job.sort_by_city.first.city).to eq(job_3.city)
      end
    end

    describe '.sort_by_interest' do
      it 'Sorts interest in reverse chronological order' do
        company = Company.create!(name: 'ESPN')
        category = Category.create!(name: 'Production')
        job_1 = Job.create!(title: 'Manager 1', level_of_interest: 80, description: 'Wahoo', city: 'Denver', company: company, category: category)
        job_2 = Job.create!(title: 'Manager 2', level_of_interest: 90, description: 'Wahoo', city: 'Bakersfield', company: company, category: category)
        job_3 = Job.create!(title: 'Manager 3', level_of_interest: 60, description: 'Wahoo', city: 'Austin', company: company, category: category)

        expect(Job.sort_by_interest.first.level_of_interest).to eq(job_2.level_of_interest)
        expect(Job.sort_by_interest.last.level_of_interest).to eq(job_3.level_of_interest)
      end
    end

    describe '.listing_location' do
      it 'Lists the jobs by specified location' do
        company = Company.create!(name: 'ESPN')
        category = Category.create!(name: 'Production')
        job_1 = Job.create!(title: 'Manager 1', level_of_interest: 80, description: 'Wahoo', city: 'Denver', company: company, category: category)
        job_2 = Job.create!(title: 'Manager 2', level_of_interest: 90, description: 'Wahoo', city: 'Bakersfield', company: company, category: category)
        job_3 = Job.create!(title: 'Manager 3', level_of_interest: 60, description: 'Wahoo', city: 'austin', company: company, category: category)
        job_4 = Job.create!(title: 'Manager 3', level_of_interest: 60, description: 'Wahoo', city: 'Denver', company: company, category: category)
        job_5 = Job.create!(title: 'Manager 3', level_of_interest: 60, description: 'Wahoo', city: 'Austin', company: company, category: category)

        location = 'Denver'
        expect(Job.listing_location(location).count).to eq(2)
      end
    end

    describe '.group_by_interest' do
      it 'Groups jobs by level of interest' do
        company = Company.create!(name: 'ESPN')
        category = Category.create!(name: 'Production')
        job_1 = Job.create!(title: 'Manager 1', level_of_interest: 80, description: 'Wahoo', city: 'Denver', company: company, category: category)
        job_2 = Job.create!(title: 'Manager 2', level_of_interest: 90, description: 'Wahoo', city: 'Bakersfield', company: company, category: category)
        job_3 = Job.create!(title: 'Manager 3', level_of_interest: 60, description: 'Wahoo', city: 'austin', company: company, category: category)
        job_4 = Job.create!(title: 'Manager 3', level_of_interest: 60, description: 'Wahoo', city: 'Denver', company: company, category: category)
        job_5 = Job.create!(title: 'Manager 3', level_of_interest: 60, description: 'Wahoo', city: 'Austin', company: company, category: category)

        expect(Job.group_by_interest.first.level_of_interest).to eq(90)
        expect(Job.group_by_interest.first.interest_count).to eq(1)
      end
    end

    describe '.group_by_location' do
      it 'Groups jobs by location' do
        company = Company.create!(name: 'ESPN')
        category = Category.create!(name: 'Production')
        job_1 = Job.create!(title: 'Manager 1', level_of_interest: 80, description: 'Wahoo', city: 'Denver', company: company, category: category)
        job_2 = Job.create!(title: 'Manager 2', level_of_interest: 90, description: 'Wahoo', city: 'Bakersfield', company: company, category: category)
        job_3 = Job.create!(title: 'Manager 3', level_of_interest: 60, description: 'Wahoo', city: 'Austin', company: company, category: category)
        job_4 = Job.create!(title: 'Manager 3', level_of_interest: 60, description: 'Wahoo', city: 'Denver', company: company, category: category)
        job_5 = Job.create!(title: 'Manager 3', level_of_interest: 60, description: 'Wahoo', city: 'Austin', company: company, category: category)
        job_6 = Job.create!(title: 'Manager 3', level_of_interest: 60, description: 'Wahoo', city: 'Austin', company: company, category: category)

        expect(Job.group_by_location.first.city_count).to eq(3)
        expect(Job.group_by_location.first.city).to eq("Austin")
      end
    end
  end
end
