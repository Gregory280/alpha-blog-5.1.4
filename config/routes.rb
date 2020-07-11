Rails.application.routes.draw do
  get 'users/new'
  root 'welcome#home'
  get 'about', to: 'welcome#about'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users, except: [:new]
  resources :articles do
    resources :comments
    resources :likes
  end
  resources :categories, except: [:destroy]
  
end
