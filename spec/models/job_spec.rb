require 'rails_helper'

describe Job do
  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid without a title' do
        job = Job.new(level_of_interest: 80, description: 'Wahoo', city: 'Denver')
        expect(job).to be_invalid
      end

      it 'is invalid without a level of interest' do
        job = Job.new(title: 'Developer', description: 'Wahoo', city: 'Denver')
        expect(job).to be_invalid
      end

      it 'is invalid without a city' do
        job = Job.new(title: 'Developer', description: 'Wahoo', level_of_interest: 80)
        expect(job).to be_invalid
      end
    end

    context 'valid attributes' do
      it 'is valid with a title, level of interest, company and category' do
        company = Company.new(name: 'Turing')
        category = Category.create!(name: 'Development')
        job = Job.new(title: 'Developer', level_of_interest: 40, city: 'Denver', company: company, category: category)
        expect(job).to be_valid
      end
    end
  end

  describe 'relationships' do
    it 'belongs to a company' do
      job = Job.new(title: 'Software', level_of_interest: 70, description: 'Wahooo')
      expect(job).to respond_to(:company)
    end

    it 'belongs to a category' do
      job = Job.new(title: 'Software', level_of_interest: 70, description: 'Wahooo')
      expect(job).to respond_to(:category)
    end
  end

  describe 'methods' do
    describe '.sorted_comments' do
      it 'sorts comments in reverse chronological order' do
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
      it 'sorts city in chronological order' do
        company = Company.create!(name: 'ESPN')
        category = Category.create!(name: 'Production')
        job_1 = Job.create!(title: 'Manager 1', level_of_interest: 60, description: 'Wahoo', city: 'Denver', company: company, category: category)
        job_2 = Job.create!(title: 'Manager 2', level_of_interest: 70, description: 'Wahoo', city: 'Bakersfield', company: company, category: category)
        job_3 = Job.create!(title: 'Manager 3', level_of_interest: 80, description: 'Wahoo', city: 'Austin', company: company, category: category)

        expect(Job.sort_by_city.first.city).to eq(job_3.city)
      end
    end

    describe '.sort_by_interest' do
      it 'sorts interest in reverse chronological order' do
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
      it 'lists the jobs by specified location' do
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

    describe '.listing_location' do
      it 'lists the jobs by specified location' do
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
      it 'groups jobs by level of interest' do
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
  end
end
