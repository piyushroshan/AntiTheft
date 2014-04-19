Rails.application.routes.draw do

  get 'activations/create'

  resources :devices

  #resources :password_resets
  post '/login' => 'user_sessions#create', :as => :user_sessions
  get '/login' => 'user_sessions#new', :as => :login
  get '/signup' => 'users#new', :as => :signup
  post '/signup' => 'users#create', :as => :create_user
  get '/logout' => 'user_sessions#destroy', :as => :logout
  get '/profile' => 'users#edit', :as => :edit_user
  post '/profile' => 'users#update', :as => :update_user
  get '/:id/profile' => 'users#edit_user', :as => :edit_users
  post '/:id/profile' => 'users#update_user', :as => :update_users
  delete '/:id/profile' => 'users#destroy_user', :as => :destroy_user
  get '/users' => 'users#index', :as => :users
  get '/password_resets' => 'password_resets#new', :as => :forgot_password
  post '/password_resets' => 'password_resets#create', :as => :create_token
  get '/password_resets/:id' => 'password_resets#edit', :as => :password_reset_form
  post '/password_resets/:id' => 'password_resets#update', :as => :reset_password
  get '/activate/:activation_code' => 'activations#create', :as => :activate
  get '/resend_activation/:username' => 'users#resend_activation', :as => :resend_activation_users
  get '/denied' => 'users#deny', :as => :denied
  get '/logs/add_log' => 'logs#new', :as => :new_log
  post '/logs/add_log' => 'logs#create', :as => :create_log
  get '/logs/:device_id/' => 'logs#index', :as => :index_logs
  delete '/logs/:device_id/:id' => 'logs#destroy', :as => :delete_log
  
  #get '/logs/:device_id/:page' => 'logs#index', :as => :index_logs_page
  get '/logs/:device_id/:id' => 'logs#new', :as => :log
  get '/logs/:device_id/:id/edit' => 'logs#edit', :as => :edit_log
  get "/uploads/:device/:model/:id/:basename.:extension" => 'logs#download', :as => :download_log
  get "/devices/stolen/:macaddress" => "devices#check_stolen", :as => :check_stolen
  
  #get '/logs/destroy_log/:id' => 'logs#destroy', :as => :log_destroy
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'users#welcome'

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
