DBMap::Application.routes.draw do
  resources :apps

  resources :environments

  resources :hostings do
    collection do
      match 'search' => 'hostings#search', :via => [:get, :post], :as => :search
    end
  end 
   resources :databases do 
 collection do
      match 'search' => 'databases#search', :via => [:get, :post], :as => :search
      match 'dataview' => 'databases#dataview',:via => [:get,:post]
      match 'db_search' => 'databases#db_search',:via => [:get,:post], :as => :db_search
     match '/db_search_view' => "databases#db_search_view"
    end

  end
   post '/options' => 'databases#options'
     match 'view_report' => 'databases#view_report'

   resources :fields do
    collection do
      match 'search' => 'fields#search', :via => [:get, :post], :as => :search
    end
   end 
   resources :tables do
    collection do
      match 'search' => 'tables#search', :via => [:get, :post], :as => :search
    end
   end 
  resources :schemas
  resources :pages
  post "pdf_report"=>"databases#pdf_report"
  get 'logout' => 'sessions#destroy', as: :logout
  get 'login' => 'sessions#new', as: :login
  get 'signup' => 'users#new', as: :signup
  get 'account' => 'users#edit', as: :account
  get '/admin' => 'admin/categories#index'
  match '/download_single_pattern/:id' => "patterns#download_single_pattern"
  match '/download_patterns' => "patterns#download_patterns"
  match '/database_schema' => "databases#database_schema"
  match '/block_tree_view' => "databases#block_tree_view"
  match '/database_schema1' => "databases#database_schema1"
  resources :users, except: :destroy
  resources :sessions, only: [:new, :create, :destroy]
  resources :patterns
match '/db_data_view' => "databases#db_data_view"

  namespace :admin do
    resources :users, except: [:show]
    resources :categories do
      collection { post :sort }
    end
    root to: "home#index"  
  end
  root to: "home_page#index"
  match '/privacy' => 'pages#privacy'
  match '/contact_us' => 'pages#new'
  match '/legal'=> 'pages#legal'
  match '/pricing' => 'pages#pricing'
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
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
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
  #       get 'recent', :on => :collection
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
