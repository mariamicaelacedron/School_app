Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :grades
    resources :students, only: [ :index, :new, :create, :show ] do
      member do
        get :get_name
      end
    end
    resources :summaries
  end

  namespace :users do
    resources :grades, only: [ :index, :show ]
    resources :summaries, only: [:index, :show]

  end

  authenticated :user, ->(u) { u.admin? } do
    root to: "admin/grades#index", as: :admin_root
  end

  authenticated :user do
    root to: "users/grades#index", as: :user_root
  end

  root "home#index"
end
