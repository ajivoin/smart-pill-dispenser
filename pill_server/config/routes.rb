# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'schedule#show'

  resource :schedules do
    collection do
      post 'reply'
    end
  end
end
