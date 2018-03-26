require 'rails_helper'

describe 'User edits an existing category' do
  scenario 'a user can edit a category' do
    category = Category.create!(name: 'Development')
    visit edit_category_path(category)

    fill_in 'category[name]', with: 'Production'
    click_button 'Update'

    expect(current_path).to eq("/category/#{Category.last.id}")
    expect(page).to have_content('Production')
    expect(page).to_not have_content('Development')
  end
end
