RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.include LoginUserMacro, :type => :controller
end
