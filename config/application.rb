# coding: utf-8
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
