EdxFive::Application.routes.draw do

  root :to => "main#index"

  get '/main', :to => "main#index"
  get 'main/search', :to => "main#search"
  post '/main/search', :to => "main#search"

  require 'resque/server'
  mount Resque::Server.new, :at => "/resque"

end
