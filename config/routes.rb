Citibike::Application.routes.draw do
  resources :searches, only: [:new, :create, :index]
  resources :users do
    # member do
    #     get 'account'
    #   end 
    resources :favorites
      member do
        post 'favorite'
      end  
  end

  get 'account' => 'welcome#account'
  root 'welcome#index'
  
  # get 'searches' => 'searches#index'
  # get 'searches/results' => 'searches#results'
  resource :session, only: [:destroy, :create, :new]
end
