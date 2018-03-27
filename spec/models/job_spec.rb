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
  end
end
