Rails.application.routes.draw do
  resources :ideas do
    resources :reviews, only: [:create, :destroy]
    get :update_likes
    patch :update_likes
    put :update_likes
  end

  resources :users, only: [:new, :create]
  
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  root 'ideas#index'
end
