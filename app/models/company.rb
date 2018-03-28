class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :jobs, dependent: :destroy
  has_many :contacts, dependent: :destroy

  def self.by_interest
    select("companies.name, AVG(jobs.level_of_interest) AS average_interest")
    .joins(:jobs)
    .order("average_interest DESC")
    .group(:id)
    .limit(3)
  end
end
