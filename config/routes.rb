Rails.application.routes.draw do

  devise_for :users, controllers: {
     sessions: 'users/sessions',
     registrations: 'registrations'
   }
  resources :posts do
    resources :comments
  end

  root 'posts#index'

end
