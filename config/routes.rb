Rails.application.routes.draw do
  devise_for :users
  root "tweets#index"
  
  namespace :admin do
    root "tweets#index"
  end

end
