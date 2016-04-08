require 'sidekiq/web'

Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # root to: 'admin/dashboard#index'

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
