Rails.application.routes.draw do
  
  # 会員用
devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

root to: 'public/homes#top'
get 'about' => 'public/homes#about'

scope module: :public do
    resources :posts,  only: [:index, :show, :new, :create, :edit, :update, :destroy] 
end


# 管理者用
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  resources :genres, only: [:index, :edit, :create, :update]
  resources :posts, only: [:index, :create, :new, :show, :edit, :update]
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
