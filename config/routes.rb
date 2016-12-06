Rails.application.routes.draw do
  root 'pages#main'
  get    '/help',    to: 'pages#help'
  get    '/contact', to: 'pages#contact'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users do
    get :confirm_email, on: :member
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
