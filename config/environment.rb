# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Citibike::Application.initialize! do
config.gem "cancan"
   
end

