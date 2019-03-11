Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  root 'static_pages#home'
  resources :users, only: %i(show)
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :posts, only: %i(index new create show destroy) do
    resources :photos, only: %i(create)
  end
  resources :relationships, only: %i(create destroy)
end