Ryunkang::Application.routes.draw do

  devise_for :users
  # devise_for :admin_users, ActiveAdmin::Devise.config

  #home
  get '/', to: 'webapp/resumes#index'

  #ActiveAdmin.routes(self)
  root "load#home"
  get "index", to: "load#index", as: "index"  # get路径　to指controller下的方法
  get "home", to: "load#home", as: "home"  # get路径　to指controller下的方法
  get "inside", to: "load#inside", as: "inside"
  get "toast", to: "load#toast", as: "toast"
  get "login", to: "load#login", as: "login"
  get "/users/code", to: "users#code", as: "code"
  get "/users/check_username_usertype",to:"users#check_username_usertype",as:"check_username_usertype"
  get "/issues/:id",to: "issues#show"


  #https://www.codefellows.org/blog/how-to-set-up-a-rails-4-2-mailer-with-sidekiq
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :users, :only => [:show, :edit, :delete, :create] do
    resources :user_albumns
  end

  namespace :api do
    scope :v1 do
      resources :jobs do
        collection do
          post :search
        end
      end

      resources :apply_records
      resources :favorite_jobs
      resource :employer_resumes, :only => [:update]
      resource :admin_roles, :only => [:update]
      resource :employer_viewers, :only => [:create]
      post 'connect_app/login_app', to:'connect_app#login_app'
      post 'connect_app/get_hospital', to: 'connect_app#get_hospital'
      get 'connect_app', to:'connect_app#index'
      get 'back_twice', to:'back_twice#index'

      resource :employer_jobs, :only => [:update, :destroy] do
        patch :view_update, on: :collection
      end
    end
  end

  ############ ryunkang ##########
  get '/webapp/home', to: 'webapp/home#index'
    #  医生端
   namespace :webapp do

     resources :users do
     end

     resources :resumes do
       get 'preview', on: :member
     end

    #  resources :searchs do
    #    get 'search', on: :collection
    #  end

     resources :hospitals
     resources :work_experiences
     resources :education_experiences
     resources :job_fairs
     resources :jobs
     resources :expect_jobs
     resources :resume_viewers, :only => [:index, :show]
     resources :apply_records, :only => [:index, :show]

     resources :certificates, :except => [:update, :edit, :show]
     resources :block_hospitals, :except => [:update, :edit, :show]

     resources :favorite_jobs, :only => [:index, :update]

     end

    #  医院端
     namespace :employer do
       resources :home, :only => :index
       resources :users, :only => [:index, :show, :update, :edit]
       resources :jobs do
         get 'preview', on: :member
       end
       resources :resumes, :only => [:index, :show, :update]
     end

    # Admin
    namespace :admin do
      resources :jobs, :only => [:index, :show] do
        get 'check', on: :collection
        patch 'update', on: :collection
      end

      resources :resumes, :only => [:index, :edit] do
        patch 'update', on: :collection
      end

      resource :users, :only => [:create, :update, :destroy, :edit] do
        get '/', to: 'users#index'
        get '/record', to: 'users#record'
      end

      resources :fairs, :except => [:destroy, :edit] do
        get '/history', to: 'fairs#history', on: :collection
        resources :fair_hospitals, :only => [:index, :create, :update]
      end

      resources :vips, :except => [:show]

      resources :hospitals, :only => [:index, :update, :create, :destroy]
    end

    # 404页面
    # get "*any", via: :all, to: "errors#not_found"
   ########### yunkang end ###########

end
