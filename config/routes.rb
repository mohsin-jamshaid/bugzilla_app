Rails.application.routes.draw do
  
  get 'home/index'
  devise_for :users
  root 'home#index'
  resources :projects do
  	member do
    	post 'assign_project'
    	delete 'remove_from_project'
    end
  end
end
