class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  belongs_to :category
  has_many :comments, dependent: :destroy

  def sorted_comments
    comments.order('comments.created_at DESC')
  end

  def self.sort_by_city
    order('city ASC')
  end

  def self.sort_by_interest
    order('level_of_interest DESC')
  end

  def self.listing_location(location)
    select('*').where( "city = '#{location.downcase}'")
  end
end
