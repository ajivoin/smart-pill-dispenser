# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/schedule', to: 'schedule#show', as: 'schedule'
  post '/schedule/:id', to: 'schedule#update'
  put '/pill/:id', to: 'schedule#new'
  delete '/schedule/:id', to: 'schedule#remove'
  get '/pill/new', to: 'pill#new'
  put '/pill', to: 'pill#create'
  get '/pill/counts', to: 'pill#get_pill_counts'
  get '/pill/taken/:taken', to: 'pill#post_taken'
  get '/history(/:pill)', to: 'pill#history', as: 'history'
  get '/pill/:id/edit', to: 'pill#edit', as: 'edit_pill'
  post '/pill/:id/edit', to: 'pill#update', as: 'update_pill'

  root to: 'schedule#show'

  resource :schedules do
    collection do
      post 'reply'
    end
  end
end
