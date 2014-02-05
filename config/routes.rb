Citibike::Application.routes.draw do
  resources :sales

  resources :appointments
  get '/comment' => 'comment#create', :as => 'comments'
  get '/rate' => 'rater#create', :as => 'rate'
  resources :searches, only: [:new, :create, :index]
  resources :exchanges  do
    member do
      put 'claim'
      put 'confirm'
    end
  end

  resources :users do
    resources :favorites
      member do
        post 'favorite'
      end  
  end

  resources :charges
  
  get 'account' => 'welcome#account'
  root 'welcome#index'
  resource :session, only: [:destroy, :create, :new]

  get '/buy/:permalink', to: 'transactions#new', as: :show_buy
  post '/buy/:permalink', to: 'transactions#create', as: :buy
  get '/pickup/:guid', to: 'transactions#pickup', as: :pickup
  get '/download/:guid', to: 'transactions#download', as: :download

end
