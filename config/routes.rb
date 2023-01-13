Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post "auth/login", to: "auth#login"
  resources :user, only: [:index, :create]
  get "user-list", to: "message#index"
  get "room-chat-list", to: "message#roomChatList"
  get "room", to: "message#roomChatDetail"
  post "message", to: "message#messageNewRoom"
  post "room/message", to: "message#messageWithRoom"
end
