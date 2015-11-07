require 'omniauth-google-oauth2'

HOSTED_DOMAIN = 'gmail.com'
KEYS = {
  'development' => {'id'     => '',
                    'secret' => ''},
  'test'        => {'id'     => '',
                    'secret' => ''},
  'staging'     => {'id'     => '',
                    'secret' => ''},
  'production'  => {'id'     => '',
                    'secret' => ''}
}

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           KEYS[Rails.env]['id'],
           KEYS[Rails.env]['secret'],
           { hd: HOSTED_DOMAIN }
end
