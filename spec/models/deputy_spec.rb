require 'rails_helper'

RSpec.describe Deputy, type: :model do
  context 'Validations' do
    it 'is valid with id_deputy, name, state, party and legislature' do
      expect(FactoryBot.build(:deputy)).to be_valid
    end

    it 'is invalid without id_deputy' do
      deputy = FactoryBot.build(:deputy, id_deputy: nil)
      deputy.valid?

      expect(deputy.errors[:id_deputy]).to include("can't be blank")
    end

    it 'is invalid with a duplicated id_deputy' do
      FactoryBot.create(:deputy, id_deputy: 204359)

      deputy = FactoryBot.build(:deputy, id_deputy: 204359)
      deputy.valid?

      expect(deputy.errors[:id_deputy]).to include("has already been taken")
    end

    it 'is invalid without a name' do
      deputy = FactoryBot.build(:deputy, name: nil)
      deputy.valid?

      expect(deputy.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without a state' do
      deputy = FactoryBot.build(:deputy, state: nil)
      deputy.valid?

      expect(deputy.errors[:state]).to include("can't be blank")
    end

    it 'is invalid without a party' do
      deputy = FactoryBot.build(:deputy, party: nil)
      deputy.valid?

      expect(deputy.errors[:party]).to include("can't be blank")
    end

    it 'is invalid without a legislature' do
      deputy = FactoryBot.build(:deputy, legislature: nil)
      deputy.valid?

      expect(deputy.errors[:legislature]).to include("can't be blank")
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

      expect(deputy.photo_url).to eq('https://www.camara.leg.br/internet/deputado/bandep/204359.jpg')
    end
  end
end
