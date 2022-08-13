require 'rails_helper'
require './app/services/CsvManager/extract_data_service.rb'

RSpec.describe CsvManager::ExtractDataService do
  context 'It will extract' do
    it 'only data from designated UF' do
      expect(CsvManager::ExtractDataService.call(file_fixture("csv_small_valid.csv")).size).to eq(7)
      expect(CsvManager::ExtractDataService.call(file_fixture("csv_small_invalid.csv")).size).to eq(0)
    end
    it 'only data from the required_headers' do
      expect(CsvManager::ExtractDataService.call(file_fixture("csv_small_valid.csv")).first.size).to eq(12)
    end
  end
end
