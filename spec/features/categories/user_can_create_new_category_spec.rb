require 'rails_helper'

describe 'user visits create new category page' do
  scenario 'they see a form to create a new category' do
    visit new_category_path

    fill_in 'category[name]', with: 'Musician'
    click_button 'Create Category'

    category = Category.all.last

    expect(current_path).to eq("/categories")
    expect(page).to have_content('Musician')
  end

  scenario 'They try to create a duplicate category' do
    category = Category.create!(name: 'Development')

    visit new_category_path

    fill_in 'category[name]', with: 'Development'
    click_button 'Create Category'

    expect(current_path).to eq(new_category_path)
  end
end
