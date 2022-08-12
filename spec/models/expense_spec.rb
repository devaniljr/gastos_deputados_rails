require 'rails_helper'

RSpec.describe Expense, type: :model do
  context 'Validations' do
    it 'is valid with type_of_expense, description, date, provider_document, provider_name, value and document_url' do
      expect(FactoryBot.build(:expense)).to be_valid
    end
    it 'is invalid without a type_of_expense' do
      expense = FactoryBot.build(:expense, type_of_expense: nil)
      expense.valid?

      expect(deputy.errors[:type_of_expense]).to include("can't be blank")
    end
    it 'is invalid without a description' do
      expense = FactoryBot.build(:expense, description: nil)
      expense.valid?

      expect(deputy.errors[:description]).to include("can't be blank")
    end
    it 'is invalid without a date' do
    expense = FactoryBot.build(:expense, date: nil)
    expense.valid?

    expect(deputy.errors[:date]).to include("can't be blank")
  end
    it 'is invalid without a provider_document' do
    expense = FactoryBot.build(:expense, provider_document: nil)
    expense.valid?

    expect(deputy.errors[:provider_document]).to include("can't be blank")
  end
    it 'is invalid without a provider_name' do
      expense = FactoryBot.build(:expense, provider_name: nil)
      expense.valid?

      expect(deputy.errors[:provider_name]).to include("can't be blank")
    end
    it 'is invalid without a value' do
      expense = FactoryBot.build(:expense, value: nil)
      expense.valid?

      expect(deputy.errors[:value]).to include("can't be blank")
    end
    it 'is invalid without a document_url' do
      expense = FactoryBot.build(:expense, document_url: nil)
      expense.valid?

      expect(deputy.errors[:document_url]).to include("can't be blank")
    end
  end

  context 'Associations' do
    it 'is associated to an deputy' do
      expecty(FactoryBot.build(:expense).deputy).to be :deputy
    end
  end

end