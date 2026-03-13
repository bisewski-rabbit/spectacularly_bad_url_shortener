Rails.application.routes.draw do
  root 'urls#index'

  get '/urls', to: 'urls#index'
  get '/urls/popular', to: 'urls#popular'
  post '/urls', to: 'urls#create'
  get '/urls/:id', to: 'urls#show'
  get '/:short_code', to: 'urls#redirect'
  get '/stats/:short_code', to: 'urls#stats'
  delete '/urls/:id', to: 'urls#destroy'
end

