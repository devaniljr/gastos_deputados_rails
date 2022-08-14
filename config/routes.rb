Rails.application.routes.draw do
  root 'expenses#index'

  get 'importar' => 'expenses#create'
  post 'importar' => 'expenses#import'

  get 'deputado/:id' => 'expenses#show', as: 'deputy'
end
