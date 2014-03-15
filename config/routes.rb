Agendator::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  root 'home#index'
  resources :reservations, only: [:index, :create, :cancel] do
    post :cancel, on: :member
  end
end
