require 'rails_helper'

RSpec.describe "Expenses", type: :request do
  context 'requests' do
    it 'get the homepage' do
      get "/"
      expect(response).to have_http_status(:success)
    end

    it 'get the deputy page' do
      deputy = FactoryBot.create(:deputy)
      FactoryBot.create(:expense, deputy: deputy)
      get "/deputado/#{deputy.id}"
      expect(response).to have_http_status(:success)
    end

    it 'get the import page' do
      get "/importar"
      expect(response).to have_http_status(:success)
    end

    it 'post the right import content' do
      include ActionDispatch::TestProcess::FixtureFile
      file = fixture_file_upload("files/csv_small_valid.csv")

      post "/importar", params: { "/importar": { csv: file } }
      expect(response).to have_http_status(:found)
    end

    it 'post the wrong import content' do
      include ActionDispatch::TestProcess::FixtureFile
      file = fixture_file_upload("files/txt_small_valid.txt")

      post "/importar", params: { "/importar": { csv: file } }
      expect(response).to have_http_status(:found)
    end

    it 'delete the import content' do
      deputy = FactoryBot.create(:deputy)
      FactoryBot.create(:expense, deputy: deputy)

      delete "/importar"
      expect(response).to have_http_status(:found)
    end
  end
end
