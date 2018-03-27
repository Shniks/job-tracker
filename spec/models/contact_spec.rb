require 'rails_helper'

describe Contact do
  describe 'validations' do
    context 'invalid attributes' do
      skip 'is invalid without attributes' do
        contact = Contact.new
        expect(contact).to be_invalid
      end

      skip 'is invalid without an email' do
        contact = Contact.new(name: 'Laura', position: 'HR Director')
        expect(contact).to be_invalid
      end

      skip 'is invalid without an position' do
        contact = Contact.new(name: 'Laura', email: 'laura@company')
        expect(contact).to be_invalid
      end

      skip 'is invalid without an position' do
        contact = Contact.new(name: 'Laura', email: 'laura@company')
        expect(contact).to be_invalid
      end
    end
  end
end
