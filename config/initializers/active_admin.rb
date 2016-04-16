ActiveAdmin.setup do |config|
  config.site_title = "Selectoscope"
  config.site_title_image = "selectoscope_logo_small.png"
  config.favicon = 'favicon.ico'
  config.site_title_link = "/"

  config.default_namespace = false

  config.authentication_method = :authenticate_user!
  config.authorization_adapter = ActiveAdmin::CanCanAdapter
  config.on_unauthorized_access = :access_denied

  config.current_user_method = :current_user
  config.logout_link_path = :destroy_user_session_path

  config.root_to = 'groups#index'

  config.comments = false
  config.batch_actions = true

  config.csv_options = { col_sep: ';' }
  config.csv_options = { force_quotes: true }
  # config.download_links = [:csv]

  config.default_per_page = 10
end
