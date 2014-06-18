Labsort::Application.routes.draw do
  #### ROOT ####
  authenticated :user do
    root to: 'home#index', as: :authenticated_root
  end

  unauthenticated do
    root to: "home#index"
  end
  
  #### API ####
  namespace :api do
    get 'fingerTapped', to: 'timelogging#fingerScanned'
  end

  #### ADMIN/AUTHENTICATION ####
  post "/users/new", to: "users#create"
  get "/timecard_manager/index"
  devise_for :users, controllers: {
    registrations: "users/registrations", 
    passwords: "users/passwords", 
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :users
  
  #### SEARCH/HOME ####
  get "home/index"
  get "home/autocomplete"
  get "search/screws", to: "home#screwSearch"
  post "/home/search/barcode", to: "home#searchbybarcode"
  post "/screws/results", to: "screws#search"
  
  #### PART SORT ####
  resources "drawers"
  resources "items"
  resources "screws"
  
  #### DRAWINGS ####
  get "/parts", to: "part_manager#index", :as => 'assemblies'
  post "/parts", to: "part_manager#create"
  get "/parts/:id/parts/new", to: "part_manager#new_part", :as => "new_part"
  put "/parts/:id/parts", to: "part_manager#create_part"
  put "/parts/:assem_id/parts/:id", to: "part_manager#update_part"
  get "/parts/:assem_id/parts/:id/edit", to: "part_manager#edit_part"
  get "/parts/new", to: "part_manager#new"
  put "/parts/:id", to: "part_manager#update"
  delete "/parts/:id", to: "part_manager#destroy"
  get "/parts/:id", to: "part_manager#show", :as => 'assembly'
  get "/parts/:id/edit", to: "part_manager#edit"
  
  #### SHOPPING LIST ####
  get "/order_items/:id/status/:verb", to: "order_items#change_status"
  get "/order_items/filter/:filter", to: "order_items#filter"
  resources :order_items

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
