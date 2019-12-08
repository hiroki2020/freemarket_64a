Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "item#index"
  resources :item, only:[:index, :create, :new]
  get 'item/try', to: 'item#try' 
end
