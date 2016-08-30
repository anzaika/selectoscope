require "sidekiq/web"

Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  resources :fasta_files, only: :show, format: :json
end
