require 'rails_helper'

RSpec.describe Deputy, type: :model do
  context 'Validations' do
    it 'is valid with number_deputy, name, state, party and legislature' do
      expect(FactoryBot.build(:deputy)).to be_valid
    end

    it 'is invalid without number_deputy' do
      deputy = FactoryBot.build(:deputy, number_deputy: nil)
      deputy.valid?

      expect(deputy.errors[:number_deputy]).to include("não pode ficar em branco")
    end

    it 'is invalid with a duplicated number_deputy' do
      FactoryBot.create(:deputy, number_deputy: 204359)

      deputy = FactoryBot.build(:deputy, number_deputy: 204359)
      deputy.valid?

      expect(deputy.errors[:number_deputy]).to include("já está em uso")
    end

    it 'is invalid without a name' do
      deputy = FactoryBot.build(:deputy, name: nil)
      deputy.valid?

      expect(deputy.errors[:name]).to include("não pode ficar em branco")
    end

    it 'is invalid without a state' do
      deputy = FactoryBot.build(:deputy, state: nil)
      deputy.valid?

      expect(deputy.errors[:state]).to include("não pode ficar em branco")
    end

    it 'is invalid without a party' do
      deputy = FactoryBot.build(:deputy, party: nil)
      deputy.valid?

      expect(deputy.errors[:party]).to include("não pode ficar em branco")
    end

    it 'is invalid without a legislature' do
      deputy = FactoryBot.build(:deputy, legislature: nil)
      deputy.valid?

      expect(deputy.errors[:legislature]).to include("não pode ficar em branco")
    end

    it 'is valid without an optional civil name' do
      expect(FactoryBot.build(:deputy_without_api_data, civil_name: nil)).to be_valid
    end

    it 'is valid without an optional email' do
      expect(FactoryBot.build(:deputy_without_api_data, email: nil)).to be_valid
    end

    it 'is valid without an optional phone' do
      expect(FactoryBot.build(:deputy_without_api_data, phone: nil)).to be_valid
    end
  end

  context 'before_save civil_name' do
    it 'civil_name is capitalized before saved to database' do
      deputy = FactoryBot.create(:deputy, civil_name: 'LEONARDO BARRETO DE MORAES')

      expect(deputy.civil_name).to eq('Leonardo Barreto De Moraes')
    end

    it 'civil_name is not capitalized if is not given' do
      deputy = FactoryBot.create(:deputy_without_api_data)

      expect(deputy.civil_name).to be_nil
    end
  end

  context 'before_validation photo_url' do
    it 'photo_url is generated before save to dabatase if api do not respond' do
      deputy = FactoryBot.create(:deputy_without_api_data, photo_url: nil)

      expect(deputy.photo_url).to eq("https://www.camara.leg.br/internet/deputado/bandep/#{deputy.number_deputy}.jpg")
    end
  end

  context '#sum_of_expenses' do
    it 'returns the sum of expenses of given deputy' do
      FactoryBot.create(:expense)

      expect(Deputy.first.sum_of_expenses).to eq(1000.to_d)
    end
  end

  context '#biggest_expense' do
    it 'returns the biggest expense of given deputy' do
      deputy = FactoryBot.create(:deputy)

      smaller_expense = FactoryBot.create(:expense, value: 100.to_d, deputy: deputy)
      biggest_expense = FactoryBot.create(:expense, value: 500.to_d, deputy: deputy)

      expect(deputy.biggest_expense).to eq(biggest_expense)
    end
  end

  context '#monthly_expenses' do
    it 'return the expenses of the given month and year' do
      deputy = FactoryBot.create(:deputy)

      expense_february_1 = FactoryBot.create(:expense, value: 500.to_d, deputy: deputy, date: Date.new(2021, 02, 15))
      expense_february_2 = FactoryBot.create(:expense, value: 1000.to_d, deputy: deputy, date: Date.new(2021, 02, 15))

      expect(deputy.monthly_expenses('02', '2021')).to eq(1500.to_d)
    end
  end

end
