Agendator::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  root 'home#index'
end
