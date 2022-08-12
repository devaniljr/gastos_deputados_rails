FactoryBot.define do
  factory :expense do
    deputy { FactoryBot.create(:deputy) }
    type_of_expense { 10 }
    description { 'HOSPEDAGEM' }
    date { DateTime.now }
    provider_document { '00811748744' }
    provider_name { 'HOTEL X' }
    value { 1000.to_d }
    document_url { 'https://www.camara.leg.br/cota-parlamentar/documentos/publ/3263/2021/7150924.pdf' }
  end
end
