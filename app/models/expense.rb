class Expense < ApplicationRecord
  belongs_to :deputy

  validates :type_of_expense, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :provider_document, presence: true
  validates :provider_name, presence: true
  validates :value, presence: true
  validates :document_url, presence: true

  def self.all_monthly_expenses(month, year)
    self.where("extract(MONTH FROM date) = ? AND extract(YEAR FROM date) = ?", month, year).sum(:value)
  end
end
