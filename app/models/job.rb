class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  belongs_to :category
  has_many :comments

  def sorted_comments
    comments.order('comments.created_at DESC')
  end
end
