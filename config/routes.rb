Rails.application.routes.draw do
  devise_for :users

  root "tweets#index"

  resources :tweets

end

# Rails.application.routes.draw do
#   devise_for :users

#   root "restaurants#index" 

#   resources :categories, only: :show
  
#   resources :users, only: [:index, :show, :edit, :update]

#   resources :followships, only: [:create, :destroy]
  
#   namespace :admin do
#     resources :restaurants
#     resources :categories
#     root "restaurants#index"
#   end

#   resources :restaurants, only: [:index, :show] do
#     resources :comments, only: [:create, :destroy]

#     collection do
#       get :feeds
#     end

#     member do
#       get :dashboard
#     end

#     member do
#       post :favorite
#       post :unfavorite
#     end
#   end  
# end
