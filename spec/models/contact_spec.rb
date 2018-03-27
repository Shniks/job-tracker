require 'rails_helper'

describe Contact do
  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid without attributes' do
        contact = Contact.new
        expect(contact).to be_invalid
      end

      it 'is invalid without an email' do
        contact = Contact.new(name: 'Laura', position: 'HR Director')
        expect(contact).to be_invalid
      end

      it 'is invalid without an position' do
        contact = Contact.new(name: 'Laura', email: 'laura@company.com')
        expect(contact).to be_invalid
      end

      it 'is invalid without a name' do
        contact = Contact.new(position: 'HR Director', email: 'laura@company.com')
        expect(contact).to be_invalid
      end

      it 'is invalid without a company' do
        contact = Contact.new(name: 'Laura', position: 'HR Director', email: 'laura@company.com')
        expect(contact).to be_invalid
      end
    end

    context 'valid attributes' do
      it 'is valid with name, position, email and company' do
        company = Company.create(name: 'IBM')
        contact = Contact.create!(name: 'Laura', position: 'HR Director', email: 'laura@company.com', company: company)
      end
    end
  end

  describe 'relationships' do
    it 'belongs to a company' do
      company = Company.create(name: 'IBM')
      contact = Contact.create!(name: 'Laura', position: 'HR Director', email: 'laura@company.com', company: company)
      expect(contact).to respond_to(:company)
    end
  end
end
