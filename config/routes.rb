Citibike::Application.routes.draw do
  resources :searches, only: [:new, :create, :index]
  resources :exchanges, only: [:new, :create, :index]
  resources :users do
    resources :favorites
      member do
        post 'favorite'
      end  
  end

  get 'account' => 'welcome#account'
  root 'welcome#index'
  resource :session, only: [:destroy, :create, :new]
end
