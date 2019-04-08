Rails.application.routes.draw do
  resources :racers do
    post "entries" => "racers#create_entry"
  end
  resources :races
  
  get '/api/races' => 'api/races#index'
  get '/api/races/:id' => 'api/races#show'
  get '/api/races/:race_id/results' => 'api/races#results'
  get '/api/races/:race_id/results/:id' => 'api/races#result', as: 'api_race_result'
  get '/api/racers' => 'api/racers#index'
  get '/api/racers/:id' => 'api/racers#show', as: 'api_racer'
  get '/api/racers/:racer_id/entries' => 'api/racers#entries'
  get '/api/racers/:racer_id/entries/:id' => 'api/racers#entry'

  post '/api/races' => 'api/races#create'
  put '/api/races/:id' => 'api/races#update'
  patch '/api/races/:id' => 'api/races#update'
  delete '/api/races/:id' => 'api/races#delete'
  
  patch '/api/races/:race_id/results/:id' => 'api/races#show_result'
end
