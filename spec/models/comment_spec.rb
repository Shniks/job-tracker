require 'rails_helper'

describe Comment do
  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid without content' do
        comment = Comment.new
        expect(comment).to be_invalid
      end

      it 'is invalid without a job' do
        comment_2 = Comment.new(content: 'The employees seem nice')

        expect(comment_2).to be_invalid
      end
    end

    context 'valid attributes' do
      it 'is vaild with content' do
        job = Job.new(level_of_interest: 80, description: 'Wahoo', city: 'Denver')
        comment_3 = Comment.new(content: 'The employees seem nice', job: job)
        expect(comment_3).to be_valid
      end
    end
  end
end
