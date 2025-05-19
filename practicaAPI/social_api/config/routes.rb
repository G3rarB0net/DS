Rails.application.routes.draw do
  resources :tareas, only: [:index, :create, :update, :destroy]
  resources :users, only: [:index, :create, :update, :destroy]
  end

# :show si quieres hacer tipo profile/:id_user
