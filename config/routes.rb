Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root "home#index"

  # 상품 관련
  resources :products do
    collection do
      get "new_arrivals"
      get "popular"
    end
  end

  # 문의 게시판
  resources :inquiries do
    resources :answers, only: [ :create ]
  end

  # 장바구니 관련
  resource :cart, only: [ :show ]
  resources :cart_items, only: [ :create, :update, :destroy ]

  # 찜하기 관련
  resources :wishlist_items, only: [ :create, :destroy ]

  # FAQ, 이용약관
  get "faq", to: "faq#index"
  get "terms", to: "terms#index"

  # 판매자 등록
  namespace :seller do
    resource :registrations, only: [ :new, :create ]
  end

  # 사용자 관련
  get "my/inquiries", to: "inquiries#my_inquiries", as: :my_inquiries
  get "my/keywords", to: "users/keywords#edit", as: :edit_keywords
  patch "my/keywords", to: "users/keywords#update", as: :update_keywords

  # 관리자 관련 (추가 - routes.rb의 가장 아래에 위치)
  namespace :admin do
    get "dashboard", to: "dashboard#index"
    resources :users, only: [ :index, :edit, :update, :destroy ]
    resources :products, only: [ :index, :destroy ]
    resources :inquiries, only: [ :index, :show, :destroy ]
  end
end