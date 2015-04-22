# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run EdxFive::Application

#require 'resque/server'
#run Rack::URLMap.new "/" => EdxFive::Application,  "/resque" => Resque::Server.new