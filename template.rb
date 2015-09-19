# coding: utf-8
dir = File.dirname(__FILE__)

gem 'slim-rails'
gem 'simple_form'
gem 'ransack'
gem 'kaminari'
gem 'active_decorator'

gem_group :development, :test do
  gem 'capistrano'
  gem 'capistrano-rbenv'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'quiet_assets'
end

# http://morizyun.github.io/blog/rails4-application-templates-heroku/
Bundler.with_clean_env do
  run 'bundle install --path=.bundle --jobs=4'
  run 'bundle exec cap install'
  remove_dir 'test'
  generate 'simple_form:install --bootstrap'
  generate 'kaminari:config'
  generate 'rspec:install'
  run "echo '--color -f d' > .rspec"
end

# rails guide (ja): http://railsguides.jp/rails_application_templates.html
# rails guide (en): http://guides.rubyonrails.org/rails_application_templates.html
# rails composer: https://github.com/RailsApps/rails-composer
# bundle exec rails new projects/tonight --skip-bundle -m /path/to/template.rb
# bundle exec rake rails:template LOCATION=/path/to/template.rb

#use_devise = if yes?('Use devise?')
#               gem 'devise'
#               gem 'devise-i18n'
#               devise_model = ask 'Please input devise model name. ex) User, Admin: '
#               true
#             else
#               false
#             end
#
#
#
#generate 'kaminari:config'
#generate 'rspec:install'
#remove_dir 'test'
#
#if use_devise
#  say 'hoge'
#  environment "config.action_mailer.default_url_options = { host: 'localhost:3000' }", env: 'development'
#  environment "config.action_mailer.default_url_options = { host: 'localhost:3000' }", env: 'test'
#  generate "devise #{devise_model}"
#  generate 'devise:views'
#  say "!!! Please set up #{devise_model} migration file and rake db:migrate !!!"
#end
