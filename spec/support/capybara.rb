RSpec.configure do |config| 
  config.before(:each, type: :system) do
    driven_by :rack_test
  end
  
  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome
  end

  config.include FactoryBot::Syntax::Methods
  config.include Devise::Test::IntegrationHelpers, type: :system
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include ApplicationHelper
end
