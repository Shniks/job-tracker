require 'rails_helper'

describe 'User edits an existing category' do
  scenario 'They can edit a category' do
    Company.create!(name: 'Luke')
    category = Category.create!(name: 'Development')
    visit edit_category_path(category)

    fill_in 'category[name]', with: 'Production'
    click_button 'Update'

    expect(current_path).to eq("/categories/#{Category.last.id}")
    expect(page).to have_content('Production')
    expect(page).to_not have_content('Development')
  end
end
