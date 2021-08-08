# https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root 'exchanges#index'
  get 'convert', to: 'exchanges#convert'
end
