require 'rails_helper'

describe 'User goes to a job page' do
  describe 'they see a comment about that job' do
    scenario 'they see the comment and its attributes' do
      company = Company.create!(name: "ESPN")
      category = Category.create!(name: "Production")
      job = Job.create!(title: "Manager", level_of_interest: 80, description: 'Wahoo', city: 'Denver', company: company, category: category)
      comment = Comment.create!(content: "This seems like a good job", job: job)

      visit company_job_path(company, job)

      expect(page).to have_content(comment.content)
      expect(page).to have_content(comment.created_at)
    end
  end
end
