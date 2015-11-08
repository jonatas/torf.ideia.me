require ::File.expand_path('../../config/environment',  __FILE__)
Rails.application.eager_load!

require 'action_cable/process/logging'

ActionCable.server.config.allowed_request_origins = 
  if Rails.env.production?
    'http://torf.r15.railsrumble.com'
  else
    "http://localhost:3000"
  end
run ActionCable.server
