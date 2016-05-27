Ryunkang::Application.routes.draw do

  namespace :webapp do
  get 'favorite_jobs/index'
  end

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

  ############ ryunkang ##########

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

     get 'resume_views/index'
     get 'resume_views/show'

     get 'apply_records/index'
     get 'apply_records/show'
     get 'favorite_jobs/index'

     end
   ########### yunkang end ###########

end
