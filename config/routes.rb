Beans::Application.routes.draw do
  # make app available offline
  offline = Rack::Offline.configure do
    cache "assets/application.js"
    cache "assets/application.css"
    network "/"
  end
  match "/application.manifest" => offline
    
  resources :transactions, :except => [:show, :new]

  # OmniAuth routes
  match '/auth/failure' => 'sessions#failure'
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/signin' => 'sessions#new', :as => :signin
  
  match '/home' => 'landing#home', :as => :home
  root :to => 'landing#index'

  # route anything unknown back to root
  match '*' => redirect('/')

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
