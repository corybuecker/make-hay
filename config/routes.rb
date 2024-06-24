# frozen_string_literal: true

Rails.application.routes.draw do
  get 'bookmarks/create'

  resources :links, only: %i[index create destroy show]
  get 'logins/new'
  get 'logins/index'
  get 'logins/callbacks', to: 'logins/callbacks#create'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'links#index'
end
