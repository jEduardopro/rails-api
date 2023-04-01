config = Rails.application.config
config.session_store :cookie_store,
                     key: '_crud-web_session',
                     expire_after: 14.days,
                     secure: true

config.middleware.use ActionDispatch::Cookies
config.middleware.use config.session_store, config.session_options