SoccerApp::Application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  scope "/admin" do
    resources :users
    match 'users/:id/delete' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  end

  resources :accounts do
    resources :teams
    resources :locations
    get "report" => 'accounts#report', as: :report
  end

  resources :categories do
    resources :tests
  end

  resources :session_plan_categories do
     resources :session_plans
  end

  resources :players 
  
  resources :test do
    resources :scores
  end

  post 'manage_scores' => 'scores#manage', as: :manage_scores
  post 'scores' => 'scores#index', as: :scores
  get 'coach/:id' => 'users#coach_profile', as: :coach
  get 'coach_admin/:id' => 'users#coach_admin_controls', as: :coach_admin
  get 'account_error' => 'users#account_error', as: :account_error
  get 'account_select' => 'users#account_select', as: :account_select
#  get '/players/new/:id' => 'players#new', as: :new_player
#  post '/players/new' => 'players#create'
#  get '/players/show/' => 'players#show', as: :players
  get '/player/history/:id/:test_id' => 'players#history', as: :player_history
  post '/player/coach_report/' => 'players#coach_report', as: :coach_report
  post '/players/compare_players/' => 'players#compare_players', as: :compare_players
  post '/players/import/' => 'players#import', as: :players_import
  post '/players/search/' => 'players#search', as: :players_search
  get '/player/:id/players_scores' => 'players#players_scores', as: :players_scores

  post 'teams/report' => 'teams#team_report', as: :team_report
  post 'tests/report' => 'tests#tests_report', as: :tests_report
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
