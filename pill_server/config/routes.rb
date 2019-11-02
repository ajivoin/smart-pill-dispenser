Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/schedule', to: 'schedule#show', as: 'schedule'
  post '/schedule/:id', to: 'schedule#update'

  root to: 'schedule#show'
end
