class Deputy < ApplicationRecord
  has_many :expenses

  before_save { self.civil_name = self.civil_name.titleize if self.civil_name.present? }
  before_validation { self.photo_url = "https://www.camara.leg.br/internet/deputado/bandep/#{self.number_deputy}.jpg" if !self.photo_url.present? }

  validates :number_deputy, presence: true, uniqueness: true
  validates :name, presence: true
  validates :state, presence: true
  validates :party, presence: true
  validates :legislature, presence: true
  validates :photo_url, presence: true

  def sum_of_expenses
    self.expenses.sum(:value)
  end

  def biggest_expense
    self.expenses.order("value DESC").first
  end

  def monthly_expenses(month, year)
    self.expenses.where("strftime('%m', date) = ? AND strftime('%Y', date) = ?", month, year).sum(:value)
  end
end
