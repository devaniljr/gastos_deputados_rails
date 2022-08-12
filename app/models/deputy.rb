class Deputy < ApplicationRecord
  has_many :expenses

  before_save { self.civil_name = self.civil_name.titleize if self.civil_name.present? }
  before_validation { self.photo_url = "https://www.camara.leg.br/internet/deputado/bandep/#{self.id_deputy}.jpg" if !self.photo_url.present? }

  validates :id_deputy, presence: true, uniqueness: true
  validates :name, presence: true
  validates :state, presence: true
  validates :party, presence: true
  validates :legislature, presence: true
  validates :photo_url, presence: true
end
