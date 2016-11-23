Rails.application.routes.draw do

  root 'welcome#index'
  resources :users, except: [:index] do
    collection do
      get :skills
      get :people
    end
    member do
      get :add_skill
      post :approve_skill
      post :disapprove_skill
    end
  end
  get    'signup'  => 'users#new'
  get    'login'   => 'session#new'
  post   'login'   => 'session#create'
  delete 'logout'  => 'session#destroy'
end
