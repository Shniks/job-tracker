require 'rails_helper'

describe 'User deletes a category' do
  scenario 'They can\'t see that category on the categories index page' do

    category = Category.create!(name: 'Development')

    visit categories_path
    click_link 'Delete'

    expect(page).to_not have_content(category.name)
  end
end
