Rails.application.routes.draw do
  root 'welcome#index'
  post 'user/new', to: 'user#create'
  resources :user
  delete 'session/destroy', to: 'session#destroy' #, as: 'ddd'   路径会变成ddd_path
  resources :session
  namespace :admin do
    root 'users#index'
    resources :users do
      collection do
        get :search
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
