Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'links#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/registrations#new', as: :unauthenticated_root
    end
  end

  get "/links", to: "links#index"
  get "/links/new", to: "links#new"
  post "/links", to: "links#create"
  get "/links/:id", to: "links#show"
  get "/links/:id/edit", to: "links#edit"
  patch "/links/:id", to: "links#update"
  delete "links/:id", to: "links#destroy"

  get "/:id", to: "visits#create"



end
