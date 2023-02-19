Rails.application.routes.draw do

# 会員用
devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

root to: 'public/homes#top'
get 'about' => 'public/homes#about'

scope module: :public do
    get 'users/my_page/edit' => 'users#edit'
    get 'users/unsubscribe' => 'users#unsubscribe'
    patch 'users/withdraw' => 'users#withdraw'
    resources :users, only: [:show, :update, :destroy] do
      member do
        get :likes
      end
    end
    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resource :likes, only: [:create, :destroy]
    resources :comments,  only: [:create, :destroy]
  end
  get '/search' => 'searches#search'
end

#ゲストログイン
devise_scope :user do
    post '/users/guest_sign_in' => 'public/sessions#guest_sign_in'
  end

# 管理者用
devise_for :admin, skip: [:registrations, :passwords], controllers: {
sessions: "admin/sessions"
}

namespace :admin do
  resources :users, only: [:index, :show, :edit, :update]
  resources :genres, only: [:index, :edit, :create, :update]
  resources :posts, only: [:index, :create, :new, :show, :edit, :update, :destroy] do
    resources :comments,  only: [:destroy]
  end
  get '/search' => 'searches#search'
end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
