Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => 'home#index'

  get 'login', to: redirect('/auth/nuxeo'), as: 'login'

  # Omniauth callback
  get '/auth/:provider/callback', to: 'sessions#create'
end
