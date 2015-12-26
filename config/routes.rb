Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  get 'amiibos', to: 'amiibos#index'
  get 'amiibos/:id', to: 'amiibos#show', as: :amiibo
  post 'amiibos/', to: 'amiibos#create'
end
