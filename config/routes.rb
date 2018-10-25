Rails.application.routes.draw do
  resources :kinds
  resources :contacts
  post '/email_check', to: 'contacts#email_check'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
