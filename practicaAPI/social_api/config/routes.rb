Rails.application.routes.draw do
  resources :tareas, only: [:index, :create, :update, :destroy]
  resources :users, only: [:index, :create, :update, :destroy]
  resources :amistades, only: [:index, :create, :update, :destroy]

  # Ruta personalizada para buscar usuario por email
  get 'users/get_by_email', to: 'users#getUserByEmail'
  post 'users/login', to: 'users#login'
end

# :show si quieres hacer tipo profile/:id_user
