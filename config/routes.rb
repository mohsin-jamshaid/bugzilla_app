Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  resources :projects do
    member do
      post 'assign_project'
      delete 'remove_from_project'
    end

    resources :bugs do
      member do
        patch 'assign_bug'
        patch 'resolve_bug'
      end
    end
  end

  mount ActionCable.server => '/cable'
end
