Rails.application.routes.draw do
  root :to => "visitors#index"
  resources :users, :only => [:index, :show]
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
  post '/send_payment' => 'dwolla#send_payment'
  get '/credentials' => 'dwolla#credentials'
end
