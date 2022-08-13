require 'rails_helper'
require './app/services/CsvManager/check_integrity_service.rb'

RSpec.describe CsvManager::CheckIntegrityService do
  it 'document only accept .csv' do
    expect(CsvManager::CheckIntegrityService.call(file_fixture("csv_small_valid.csv"))).to be_truthy
    expect(CsvManager::CheckIntegrityService.call(file_fixture("txt_small_valid.txt"))).to be_falsy
  end
  it 'document is valid if has the necessary attributes in the header' do
    expect(CsvManager::CheckIntegrityService.call(file_fixture("csv_small_valid.csv"))).to be_truthy
  end
  it 'document is invalid if do not have the necessary attributes in the header' do
    expect(CsvManager::CheckIntegrityService.call(file_fixture("csv_small_invalid.csv"))).to be_falsy
  end
end
