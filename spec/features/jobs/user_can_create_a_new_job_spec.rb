require 'rails_helper'

describe "User creates a new job" do
  scenario "A user can create a new job" do
    company = Company.create!(name: "ESPN")
    visit new_job_path

    select "Development", from: "Category"
    fill_in "job[title]", with: "Developer"
    select "ESPN", from: "Companies"
    fill_in "job[city]", with: "Denver"
    fill_in "job[description]", with: "So fun!"
    fill_in "job[level_of_interest]", with: 80

    click_button "Create"

    expect(current_path).to eq("/job/#{Job.last.id}")
    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("80")
    expect(page).to have_content("Denver")
  end
end
