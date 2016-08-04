require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Ryunkang
  class Application < Rails::Application
        config.to_prepare do
      # Load application's model / class decorators
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.default_locale = :zh

    # turn off warnings triggered by friendly_id
    I18n.enforce_available_locales = false
    # turn off warnings triggered by active record
    config.active_record.raise_in_transactional_callbacks = true
    # use assets
    config.assets.enabled = true
    # Test framework
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: true,
                       controller_specs: true,
                       request_specs: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    # autoload lib path

  # 设置404页面
  config.exceptions_app = self.routes



    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.autoload_paths += %W(#{Rails.root}/app/workers)
    config.weixin_token = 'weixin'
    ENV["APPID"]="wx3e615f91a151f3e1" #'wxf775b6608a7ffa94' # "wx3e615f91a151f3e1"
    ENV["APPSECRET"]="faaa64b9fa3cfa57ab5a802ce42b44b9"   #'d5c1c6c10097c7dc47a10c7b436a0f50'  #"faaa64b9fa3cfa57ab5a802ce42b44b9"

  end

end
