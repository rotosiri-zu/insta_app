Rails.application.routes.draw do
  devise_for :users, controllers: {
                                    omniauth_callbacks: "users/omniauth_callbacks",
                                    registrations: "users/registrations"}
  root "posts#index"
  get  "/home", to: "static_pages#home"
  get  "/about", to: "static_pages#about"
  resources :users do
    member do
      get :following, :followers, :likes, :liked, :notifications, :dm, :foot_stamps
      put :notification_check
    end
  end
  resources :posts, only: %i(index new create show destroy) do
    resources :photos, only: %i(create)
    resources :likes, only: %i(create destroy), shallow: true
    resources :comments, only: %i(create destroy), shallow: true
  end
  resources :relationships, only: %i(create destroy)
  resources :direct_messages, only: %i(create)
  resources :direct_message_spaces, only: %i(create show)
  resources :hashtags, param: :hashname, only: %i(index show)
end
