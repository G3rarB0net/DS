Rails.application.routes.draw do

  resources :tareas, only: [:index, :create, :update, :destroy] do
    member do
      post 'usuarios/:usuario_id', to: 'asignacion_tareas#create'
      delete 'usuarios/:usuario_id', to: 'asignacion_tareas#destroy'
    end
  end
  
  resources :users, only: [:index, :create, :update, :destroy]
  resources :amistades, only: [:index, :create, :update, :destroy]
  
  get 'tareas/:id/usuarios', to: 'tareas#usuarios_asignados'

  

  # Ruta personalizada para buscar usuario por email
  get 'users/get_by_email', to: 'users#getUserByEmail'
  post 'users/login', to: 'users#login'
end

# :show si quieres hacer tipo profile/:id_user
