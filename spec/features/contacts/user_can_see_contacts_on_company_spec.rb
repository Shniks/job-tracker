require 'rails_helper'

describe 'User goes to a company page' do
  describe 'They see contacts from that company' do
    scenario 'They see the contacts and their attributes' do
      company = Company.create!(name: 'ESPN')
      contact = Contact.create!(name: 'Laura', position: 'HR Director', email: 'laura@company.com', company: company)

      visit company_path(company)

      expect(page).to have_content(contact.name)
      expect(page).to have_content(contact.position)
      expect(page).to have_content(contact.email)
    end
  end

  describe 'They see a new contact form' do
    scenario 'They submit a new contact' do
      company = Company.create!(name: 'IBM')

      visit company_path(company)

      fill_in 'contact[name]', with: 'Mike'
      fill_in 'contact[position]', with: 'Duty Manager'
      fill_in 'contact[email]', with: 'mike@ibm.com'
      click_button 'Create Contact'

      expect(page).to have_content('Mike')
      expect(page).to have_content('Duty Manager')
      expect(page).to have_content('mike@ibm.com')
    end
  end
end
