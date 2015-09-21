# coding: utf-8
dir = File.dirname(__FILE__)

# get '/' => どこかに指定
# get '/me' => どこかに指定
# db -> mysql, db:migrate
# unicorn
# capistrano

# questions
use_devise = if yes?('Use devise?')
               gem 'devise'
               gem 'devise-i18n'
               gem 'omniauth-facebook'
               gem 'omniauth-twitter'
               gem 'omniauth-google-oauth2'
               gem 'omniauth-yahoojp'
               true
             else
               false
             end

# production gems
gem 'slim-rails'
gem 'simple_form'
gem 'ransack'
gem 'kaminari'
gem 'active_decorator'

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
  remove_dir 'test'
  run 'bundle install --path=.bundle --jobs=4'
  run 'bundle exec cap install'
  generate 'simple_form:install --bootstrap'
  generate 'kaminari:config'
  generate 'rspec:install'

  if use_devise
    environment "config.action_mailer.default_url_options = { host: 'localhost:3000' }", env: 'development'
    environment "config.action_mailer.default_url_options = { host: 'localhost:3000' }", env: 'test'
    if !File.exists?("config/initializers/devise.rb")
      generate 'devise:install'
    end
    if !File.exists?("app/views/devise")
      generate 'devise:views'
    end
    if !File.exists?("app/models/user.rb")
      generate 'devise User'
    end
    if !File.exists?('app/controllers/me_controller.rb')
      file 'app/controllers/me_controller.rb',
           File.open(dir+"/app/controllers/me_controller.rb").read
      file 'app/views/me/index.html.slim',
           File.open(dir+"/app/views/me/index.html.slim").read
      route "get '/me' => 'me#index'"
      #file 'app/controllers/users/registrations_controller.rb',
      #     File.open(dir+"/app/controllers/users/registrations_controller.rb").read
      #route 'devise_for :users, controllers: { registrations: "users/registrations" }'
    end
  end

  application do File.open("config/application.rb").read end

  if !File.exists?('app/controllers/service_controller.rb')
    generate "controller service index"
    route "root 'service#index'"
  end
  
  run 'bundle exec rake db:migrate'
end

# bundle exec rails new projects/tonight --skip-bundle -m /path/to/template.rb
# bundle exec rake rails:template LOCATION=/path/to/template.rb
# rails guide (ja): http://railsguides.jp/rails_application_templates.html
# rails guide (en): http://guides.rubyonrails.org/rails_application_templates.html
