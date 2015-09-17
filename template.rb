# coding: utf-8
dir = File.dirname(__FILE__)

gem 'slim-rails'
gem 'simple_form'
gem 'ransack'
gem 'kaminari'
gem 'active_decorator'
gem 'unicorn'

remove_dir 'test'

# http://morizyun.github.io/blog/rails4-application-templates-heroku/
Bundler.with_clean_env do
  run 'bundle install --path=.bundle --jobs=4'
end

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
