class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :jobs, dependent: :destroy
  has_many :contacts, dependent: :destroy

  def self.by_interest
    select("companies.name, companies.id, ROUND(AVG(jobs.level_of_interest), 1) AS average_interest")
    .joins(:jobs)
    .order("average_interest DESC")
    .group(:id)
    .limit(3)
  end
end
