require 'rails_helper'

RSpec.describe Expense, type: :model do
  context 'Validations' do
    it 'is valid with type_of_expense, description, date, provider_document, provider_name, value and document_url' do
      expect(FactoryBot.build(:expense)).to be_valid
    end

    it 'is invalid without a type_of_expense' do
      expense = FactoryBot.build(:expense, type_of_expense: nil)
      expense.valid?

      expect(expense.errors[:type_of_expense]).to include("não pode ficar em branco")
    end

    it 'is invalid without a description' do
      expense = FactoryBot.build(:expense, description: nil)
      expense.valid?

      expect(expense.errors[:description]).to include("não pode ficar em branco")
    end

    it 'is invalid without a date' do
    expense = FactoryBot.build(:expense, date: nil)
    expense.valid?

    expect(expense.errors[:date]).to include("não pode ficar em branco")
    end

    it 'is invalid without a provider_document' do
    expense = FactoryBot.build(:expense, provider_document: nil)
    expense.valid?

    expect(expense.errors[:provider_document]).to include("não pode ficar em branco")
    end

    it 'is invalid without a provider_name' do
      expense = FactoryBot.build(:expense, provider_name: nil)
      expense.valid?

      expect(expense.errors[:provider_name]).to include("não pode ficar em branco")
    end

    it 'is invalid without a value' do
      expense = FactoryBot.build(:expense, value: nil)
      expense.valid?

      expect(expense.errors[:value]).to include("não pode ficar em branco")
    end

    it 'is invalid without a document_url' do
      expense = FactoryBot.build(:expense, document_url: nil)
      expense.valid?

      expect(expense.errors[:document_url]).to include("não pode ficar em branco")
    end
  end
end
