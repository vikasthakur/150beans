Beans::Application.routes.draw do |map|
  resources :transactions

  # Ledger entries should not be reachable. They should only be created internally
  # by the transactions model and made available as part of an account query.
  #
  # resources :ledger_entries
  # resources :debit_entries, :controller => 'ledger_entries'
  # resources :credit_entries, :controller => 'ledger_entries'

  resources :accounts
  resources :debit_accounts, :controller => 'accounts'
  resources :credit_accounts, :controller => 'accounts'
  resources :asset_accounts, :controller => 'accounts'
  resources :equity_accounts, :controller => 'accounts'
  resources :expenses_accounts, :controller => 'accounts'
  resources :income_accounts, :controller => 'accounts'
  resources :liability_accounts, :controller => 'accounts'

  resources :currencies
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
