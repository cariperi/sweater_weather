Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get '/forecast', to: 'forecast#search'
      post '/users', to: 'users#create'
    end
  end
end
