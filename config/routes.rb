Rails.application.routes.draw do
  get 'book/new'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  root 'homes#top'
  get 'mypage', to: 'homes#mypage'
  get 'search', to: 'searches#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
