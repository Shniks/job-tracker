require 'rails_helper'

describe 'user visits create new category page' do
  scenario 'they see a form to create a new category' do
    visit new_category_path

    fill_in 'category[name]', with: 'Musician'
    click_button 'Create Category'

    expect(current_path).to eq('/categories')
    expect(page).to have_content('Musician')
  end
end
