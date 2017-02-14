Rnoteheaven::Application.routes.draw do

    devise_for :users

  #home
  get '/', to: 'pages#index'

  # #ActiveAdmin.routes(self)
  # root "load#home"
  # get "index", to: "load#index", as: "index"  # get路径　to指controller下的方法
  # get "/issues/:id",to: "issues#show"


  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :users do
  end

  resources :pages
  resources :articles do
    get "recom_articles", on: :collection
  end
  resources :notes do
    get "phone_notes", on: :collection
  end
  resources :user_albumns
  resources :collections, :only => [:index]
  resources :favorite_articles
  resources :comments
  resources :recommends

    # 404页面
    # get "*any", via: :all, to: "errors#not_found"
   ########### Rnoteheaven end ###########

end
