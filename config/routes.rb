Rails.application.routes.draw do
  resources :boards
  resources :comments, only: %i[create destroy]
end
