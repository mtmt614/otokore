Rails.application.routes.draw do

  # 会員用
devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

root to: 'public/homes#top'
get 'about' => 'public/homes#about'

scope module: :public do
    get 'users/unsubscribe' => 'users#unsubscribe'
    patch 'users/withdraw' => 'users#withdraw'
    resources :users, only: [:update, :destroy]
    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resource :likes, only: [:create, :destroy]
    resources :comments,  only: [:create, :destroy]
  end
end
get 'users/my_page/edit' => 'public/users#edit'
get 'users/my_page' => 'public/users#show'



# 管理者用
devise_for :admin, skip: [:registrations, :passwords], controllers: {
sessions: "admin/sessions"
}

namespace :admin do
  resources :users, only: [:index, :show, :edit, :update]
  resources :genres, only: [:index, :edit, :create, :update]
  resources :posts, only: [:index, :create, :new, :show, :edit, :update]
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
