Rails.application.routes.draw do
  get 'admin' => 'admin#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  resources :users

  resources :support_requests, only: [:index, :update]

  concern :reviewable do
    resources :reviews
  end

  scope '(:locale)' do
    resources :products, concern: :reviewable do
      get :who_bought, on: :member
    end
    resources :orders do
      post :ship, on: :member
    end
    resources :line_items do
      post :decrement, on: :member
    end
    resources :carts
    root 'store#index', as: 'store_index', via: :all
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
