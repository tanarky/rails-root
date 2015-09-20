# coding: utf-8
dir = File.dirname(__FILE__)

# get '/' => どこかに指定
# get '/me' => どこかに指定
# db -> mysql, db:migrate
# unicorn
# capistrano

# production gems
gem 'slim-rails'
gem 'simple_form'
gem 'ransack'
gem 'kaminari'
gem 'active_decorator'
use_devise = if yes?('Use devise?')
               gem 'devise'
               gem 'devise-i18n'
               devise_model = ask 'Please input devise model name. ex) User, Admin: '
               true
             else
               false
             end

# development gems
gem_group :development, :test do
  gem 'capistrano'
  gem 'capistrano-rbenv'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'quiet_assets'
  gem 'html2slim'
  # N+1問題の検出
  gem 'bullet'
  gem 'rspec-rails'
end

# http://morizyun.github.io/blog/rails4-application-templates-heroku/
Bundler.with_clean_env do
  run 'bundle install --path=.bundle --jobs=4'
  run 'bundle exec cap install'
  generate 'simple_form:install --bootstrap'
  generate 'kaminari:config'
  generate 'rspec:install'
  run "echo '--color -f d' > .rspec"

  if use_devise
    environment "config.action_mailer.default_url_options = { host: 'localhost:3000' }", env: 'development'
    environment "config.action_mailer.default_url_options = { host: 'localhost:3000' }", env: 'test'
    generate 'devise:install'
    generate 'devise:views'
    generate "devise #{devise_model}"
    run 'bundle exec rake db:migrate'
    generate :controller, "me", "index", "--skip-routes"
    route "get '/me' => 'me#index'"
  end

  generate "controller service index"
  route "root 'service#index'"
end

remove_dir 'test'
application do
  %q{
  # Set timezone
  config.time_zone = 'Tokyo'
  config.active_record.default_timezone = :local
  # 日本語化
  I18n.enforce_available_locales = true
  config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
  config.i18n.default_locale = :ja
  # generatorの設定
  config.generators do |g|
    g.orm :active_record
    g.template_engine :slim
    g.test_framework  :rspec, :fixture => true
    g.fixture_replacement :factory_girl, :dir => "spec/factories"
    g.view_specs false
    g.controller_specs true
    g.routing_specs false
    g.helper_specs false
    g.request_specs false
    g.assets false
    g.helper false
  end
  config.autoload_paths += Dir["#{config.root}/lib"]
  config.autoload_paths += Dir["#{config.root}/lib/**/"]
  }
end



# bundle exec rails new projects/tonight --skip-bundle -m /path/to/template.rb
# bundle exec rake rails:template LOCATION=/path/to/template.rb
# rails guide (ja): http://railsguides.jp/rails_application_templates.html
# rails guide (en): http://guides.rubyonrails.org/rails_application_templates.html
