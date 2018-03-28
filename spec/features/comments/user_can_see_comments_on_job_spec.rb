require 'rails_helper'

describe 'User goes to a job page' do
  describe 'They see a comment about that job' do
    scenario 'They see the comment and its attributes' do
      company = Company.create!(name: 'ESPN')
      category = Category.create!(name: 'Production')
      job = Job.create!(title: 'Manager', level_of_interest: 80, description: 'Wahoo', city: 'Denver', company: company, category: category)
      comment = Comment.create!(content: 'This seems like a good job', job: job)

      visit job_path(job)

      expect(page).to have_content(comment.content)
      expect(page).to have_content(comment.created_at)
    end
  end

  describe 'They see a new comment form' do
    scenario 'They submit a new comment' do
      company = Company.create!(name: 'ESPN')
      category = Category.create!(name: 'Production')
      job = Job.create!(title: 'Manager', level_of_interest: 80, description: 'Wahoo', city: 'Denver', company: company, category: category)

      visit job_path(job)
      fill_in 'comment[content]', with: 'I don\'t want this job'
      click_button 'Create Comment'

      expect(page).to have_content('I don\'t want this job')
    end
  end

  describe 'They see all comments in reverse chronological order' do
    scenario 'They see newest comment first' do
      company = Company.create!(name: 'ESPN')
      category = Category.create!(name: 'Production')
      job = Job.create!(title: 'Manager', level_of_interest: 80, description: 'Wahoo', city: 'Denver', company: company, category: category)
      Comment.create!(content: 'This seems like a good job', job: job)
      Comment.create!(content: 'Actually, this doesn\'t seem like a good job', job: job)
      comment_3 = Comment.create!(content: 'Avoid this job', job: job)

      visit job_path(job)

      expect(page.first(:xpath, '//tr')).to have_content(comment_3.content)
    end
  end
end
