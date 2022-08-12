class Expense < ApplicationRecord
  belongs_to :deputy

  validates :type_of_expense, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :provider_document, presence: true
  validates :provider_name, presence: true
  validates :value, presence: true
  validates :document_url, presence: true
end
