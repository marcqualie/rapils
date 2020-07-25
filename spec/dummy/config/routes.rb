Rails.application.routes.draw do
  resources :permissions, only: %i[create index destroy], controller: 'rapils/controllers/permissions'
end
