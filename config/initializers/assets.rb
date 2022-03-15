# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( bootstrap/css/bootstrap.min)
Rails.application.config.assets.precompile += %w( feather/css/feather )
Rails.application.config.assets.precompile += %w( jquery-scrollbar/css/perfect-scrollbar )
Rails.application.config.assets.precompile += %w( application-mailer.scss )
Rails.application.config.assets.precompile += %w( datta/datta-icon )
Rails.application.config.assets.precompile += %w( lightbox2-master/images/close.png )
Rails.application.config.assets.precompile += %w( lightbox2-master/images/loading.gif )
Rails.application.config.assets.precompile += %w( lightbox2-master/images/next.png )
Rails.application.config.assets.precompile += %w( lightbox2-master/images/prev.png )
