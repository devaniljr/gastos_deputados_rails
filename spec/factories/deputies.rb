FactoryBot.define do
  factory :deputy do
    id_deputy { 204359 }
    name { "Léo Morais" }
    state { "RO" }
    party { "PODE" }
    legislature { 2019 }
    civil_name { "LEONARDO BARRETO DE MORAES" }
    photo_url { "https://www.camara.leg.br/internet/deputado/bandep/204359.jpg" }
    email { "dep.leomoraes@camara.leg.br" }
    phone { "3215-5503" }
  end

  factory :deputy_without_api_data do
    id_deputy { 204359 }
    name { "Léo Morais" }
    state { "RO" }
    party { "PODE" }
    legislature { 2019 }
    civil_name { nil }
    photo_url { nil }
    email { nil }
    phone { nil }
  end
end
