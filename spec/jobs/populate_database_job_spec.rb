require 'rails_helper'

RSpec.describe PopulateDatabaseJob, type: :job do
  context '#perform_later' do
    it "uploads a backup" do
      file = fixture_file_upload("files/csv_small_valid.csv")

      ActiveJob::Base.queue_adapter = :test
      expect {PopulateDatabaseJob.perform_later(file.path)}.to have_enqueued_job
    end
  end
  context '#perform' do
    it 'populate deputies table' do
      file = fixture_file_upload("files/csv_small_valid.csv")

      ActiveJob::Base.queue_adapter = :test
      PopulateDatabaseJob.perform_now(file.path)

      expect(Deputy.count).to be(2)
    end
    it 'populate expenses table' do
      file = fixture_file_upload("files/csv_small_valid.csv")

      ActiveJob::Base.queue_adapter = :test
      PopulateDatabaseJob.perform_now(file.path)

      expect(Expense.count).to be(7)
    end
  end
end
