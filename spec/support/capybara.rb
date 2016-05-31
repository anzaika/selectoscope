RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.before :suite do
    Warden.test_mode!
  end
end

# RSpec.configure do |config|
#   config.before(:suite) do
#     @admin_user = Fabricate(:user, role: "admin")
#     @dev_user = Fabricate(:user)
#   end
#
# end
