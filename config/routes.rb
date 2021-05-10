Rails.application.routes.draw do
  root 'welcome#index'
  resources :user
  delete 'session/destroy', to: 'session#destroy' #, as: 'ddd'   路径会变成ddd_path
  resources :session
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
