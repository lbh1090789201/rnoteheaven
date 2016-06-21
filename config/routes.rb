Ryunkang::Application.routes.draw do

  # This line mounts Refinery's routes at the root of your application.
  # This means, any requests to the root URL of your application will go to Refinery::PagesController#home.
  # If you would like to change where this extension is mounted, simply change the
  # configuration option `mounted_path` to something different in config/initializers/refinery/core.rb
  #
  # We ask that you don't use the :as option here, as Refinery relies on it being the default of "refinery"
  # mount Refinery::Core::Engine, at: Refinery::Core.mounted_path
  # mount Refinery::Core::Engine, at: '/site'

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

  namespace :admin do
    # root "base#index"
    resources :users
  end

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
      resource :employer_jobs, :only => [:update]
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

     resources :searchs do
       get 'search', on: :collection
     end

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

     resources :favorite_jobs, :only => [:index]

     end

    #  医院端
     namespace :employer do
       resources :home, :only => :index
       resources :users, :only => [:index, :show, :update]
       resources :jobs, :only => [:index, :show, :update, :create, :destroy, :new] do
         get 'preview', on: :member
       end
       resources :resumes, :only => [:index, :show, :update]
     end
   ########### yunkang end ###########

end
